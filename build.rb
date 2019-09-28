#!/usr/bin/env ruby

# Usage:
#  ./build $env
#
# env: production, development(default)

require 'yaml'
require 'json'
require 'fileutils'

module Build

  def self.perform(output_dir, deploy_path)
    Dir.glob("plans/*/plans.yaml") do |filename|
      renderIndexAndPlans(output_dir, deploy_path, filename)
    end
    puts "OK"
  end

  def self.renderIndexAndPlans(output_dir, deploy_path, filename)
    yaml = YAML.load(File.open(filename, 'r').read)
    folder = filename.gsub('/plans.yaml', '')

    url = File.join(deploy_path, folder, 'index.json')
    indexFilename = File.join(output_dir, folder, 'index.json')

    update_url = File.join(deploy_path, folder, "#{yaml['version']}.json")
    plansFilename = File.join(output_dir, folder, "#{yaml['version']}.json")

    index = {
      name: yaml['name'],
      description: yaml['description'],
      size: yaml['plans'].size,
      latestVersion: yaml['version'],
      url: url,
      updateUrl: update_url
    }

    mkdir(indexFilename)
    File.open(indexFilename, 'w') {|f| f.write JSON.pretty_generate(index)}
    File.open(plansFilename, 'w') {|f| f.write JSON.pretty_generate(yaml['plans'])}

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
