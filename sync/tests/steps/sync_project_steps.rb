require 'fileutils'
require 'open3'

Given('a YAML input') do |yaml|
  @yaml_input = yaml
end

When('I run the sync_project script') do
  @output, @status = Open3.capture2e("ruby sync/sync_project.rb", stdin_data: @yaml_input)
end

Then('the following files should be created:') do |table|
  table.raw.flatten.each do |file|
    expect(File).to exist(file)
  end
end
