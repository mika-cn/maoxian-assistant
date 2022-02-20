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

  # validate plan.json, return invalid count
  def self.perform(filename)
    count = 0
    begin
      json = JSON.parse(File.open(filename, 'r').read);
      if json.is_a? Array
        json.each do |it|
          plan = MxPlan.new(it)
          unless plan.valid?
            puts "Invalid plan: "
            puts JSON.pretty_generate(it)
            puts "Details: "
            puts plan.errors
            count += 1
          end
        end
      else
        puts "[E] #{filename} is not an array"
      end
      return count
    rescue JSON::ParserError => e
      throw e
    end
  end

end

module Build

  def self.perform(output_dir, deploy_path)
    channels = [];
    Dir.glob("plans/channel_*.json") do |filename|
      channel = JSON.parse(File.open(filename, 'r').read)
      channels.push channel
    end

    channels.each do |channel|
      invalid_plan_count = 0
      Dir.glob("plans/#{channel['folder']}/*.json") do |filename|
        invalid_plan_count += Check.perform(filename)
      end

      if invalid_plan_count == 0
        puts "Channel #{channel['name']} OK"
        renderIndexAndPlans(output_dir, deploy_path, channel)
      else
        puts "Channel #{channel['name']} was not build, there're #{invalid_plan_count} invalid plans"
      end
    end
    puts "\nComplete!\n"
  end

  def self.renderIndexAndPlans(output_dir, deploy_path, channel)
    plans = []
    version = 0;
    Dir.glob("plans/#{channel['folder']}/*.json") do |filename|
      json = JSON.parse(File.open(filename, 'r').read)
      json.each  do |it|
        if it['version'] > version
          version = it['version']
        end
        plans << MxPlan.new(it)
      end
    end

    if version == 0
      puts "Not plan to render"
    end

    folder = "plans/#{channel['folder']}"

    url = File.join(deploy_path, folder, 'index.json')
    indexFilename = File.join(output_dir, folder, 'index.json')

    update_url = File.join(deploy_path, folder, "#{version}.json")
    plansFilename = File.join(output_dir, folder, "#{version}.json")

    index = {
      name: channel['name'],
      description: channel['description'],
      size: plans.size,
      latestVersion: version,
      url: url,
      updateUrl: update_url
    }

    mkdir(indexFilename)
    File.open(indexFilename, 'w') {|f| f.write JSON.pretty_generate(index)}
    File.open(plansFilename, 'w') {|f| f.write JSON.pretty_generate(plans.map(&:to_hash))}

    puts indexFilename
    puts plansFilename
    puts "[Done] channel: #{channel['name']}"
    puts ""
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
