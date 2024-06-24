#!/usr/bin/env ruby

require 'yaml'
require 'fileutils'
require 'optparse'

def create_files_from_yaml(data, base_path = nil)
  summaries = []

  data['files'].each do |file|
    path = file['path']
    next if base_path && !path.start_with?(base_path)

    content = file['content']
    dirname = File.dirname(path)
    FileUtils.mkdir_p(dirname) unless File.directory?(dirname)

    File.open(path, 'w') { |f| f.write(content) }
    summaries << "#{path}: #{content.lines.first.strip}"
  end

  summaries
end

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: sync_project.rb [options]"
  opts.on("--path PATH", "Base path to narrow the scope of files processed") do |v|
    options[:path] = v
  end
end.parse!

yaml_content = STDIN.read
data = YAML.safe_load(yaml_content)

summaries = create_files_from_yaml(data, options[:path])
summaries.each { |summary| puts summary }
