#!/usr/bin/env ruby

# Usage:
#   ./build tmp/myplans.json

require 'yaml'
require 'json'

module Convert
  def self.perform(filename)
    begin
      plans = JSON.parse(File.open(filename, 'r').read)
      $stdout.puts(YAML.dump(plans))
      $stdout.flush
    rescue => e
      $stderr.puts(e.inspect)
      $stderr.flush
    end
  end
end

json_file = ARGV[0]

if !json_file
  puts "Usage ./json2yaml.rb path/to/plans.json"
  exit 1
end

Convert.perform(json_file)

