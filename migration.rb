#!/usr/bin/env ruby

require 'fileutils'
require_relative 'migrations/convert_to_actions.rb'

# convert plan structure to:
# {actions: [...]}

def migrate
  Dir.glob('plans/*/*.json') do |file|
    MigrationConvertToActions.migrate(file, file)
  end
end

def main
  if !Dir.exist? 'tmp'
    FileUtils.mkdir 'tmp'
  end

  if Dir.exist? 'tmp/plans'
    FileUtils.rm_r 'tmp/plans'
  end

  FileUtils.cp_r 'plans', 'tmp/'

  begin
    migrate
  rescue => e
    puts "Error occured"
    puts "The original plans are backuped inside tmp/plans"
    puts "Restore it from there"
    puts e
    exit 1
  end

  puts "All plan converted"
  puts "If anything goes wrong, plase restore from tmp/plans"
end

main
