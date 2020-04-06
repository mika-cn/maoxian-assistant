#!/usr/bin/env ruby

# Usage:
#  ./build $env
#
# env: production, development(default)

require 'yaml'
require 'json'
require 'fileutils'
require_relative 'lib/mx-plan'

module Check

  # check plan in file and return invalid plan count
  def self.perform(filename)
    count = 0
    begin
      puts "\n\nStart to check #{filename}"
      json = JSON.parse(File.open(filename, 'r').read)
      json['plans'].each do |it|
        plan = MxPlan.new(it)
        unless plan.valid?
          count += 1
          puts "Invalid plan: "
          puts JSON.pretty_generate(it)
          puts "Details: "
          puts plan.errors
        end
      end
    rescue JSON::ParserError => e
      throw e
    end
    return count
  end

end

module Build

  def self.perform(output_dir, deploy_path)
    Dir.glob("plans/*/plans.json") do |filename|
      invalid_plan_count = Check.perform(filename)
      if invalid_plan_count == 0
        puts "File #{filename} OK"
        renderIndexAndPlans(output_dir, deploy_path, filename)
      else
        puts "File #{filename} is not going to build, because there are #{invalid_plan_count} invalid plan"
      end
    end
    puts "\nComplete!\n"
  end

  def self.renderIndexAndPlans(output_dir, deploy_path, filename)
    json = JSON.parse(File.open(filename, 'r').read)
    folder = filename.gsub('/plans.json', '')

    url = File.join(deploy_path, folder, 'index.json')
    indexFilename = File.join(output_dir, folder, 'index.json')

    update_url = File.join(deploy_path, folder, "#{json['version']}.json")
    plansFilename = File.join(output_dir, folder, "#{json['version']}.json")

    index = {
      name: json['name'],
      description: json['description'],
      size: json['plans'].size,
      latestVersion: json['version'],
      url: url,
      updateUrl: update_url
    }

    mkdir(indexFilename)
    plans = json['plans'].map{|it| MxPlan.new(it)}
    File.open(indexFilename, 'w') {|f| f.write JSON.pretty_generate(index)}
    File.open(plansFilename, 'w') {|f| f.write JSON.pretty_generate(plans.map(&:to_hash))}

    puts ""
    puts indexFilename
    puts plansFilename
    puts "[Done] #{filename}"
  end

  def self.mkdir(filename)
    dir = File.dirname(filename)
    unless File.exist?(dir)
      FileUtils.mkdir_p(dir)
    end
  end


end

script_dir = File.expand_path('..', __FILE__)
if FileUtils.pwd != script_dir
  puts "[Error] Please execute this script in #{script_dir}"
  exit 1
end


env = (ARGV[0] || 'development')
if env == 'production'
  config = YAML.load(File.open('./config.production.yaml', "r").read)
else
  config = YAML.load(File.open('./config.yaml', "r").read)
end

Build.perform(config['output_dir'], config['deploy_path'])
