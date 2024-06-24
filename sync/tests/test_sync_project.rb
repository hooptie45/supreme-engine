require 'rspec'
require 'fileutils'
require_relative '../sync/sync_project'

RSpec.describe 'SyncProject' do
  let(:test_dir) { 'test_sync_project' }
  let(:yaml_data) do
    {
      'files' => [
        { 'path' => "#{test_dir}/test_file_1.txt", 'content' => 'Test content for file 1.' },
        { 'path' => "#{test_dir}/test_file_2.txt", 'content' => 'Test content for file 2.' }
      ]
    }
  end

  before do
    FileUtils.mkdir_p(test_dir)
  end

  after do
    FileUtils.rm_rf(test_dir)
  end

  it 'creates files from YAML data' do
    summaries = create_files_from_yaml(yaml_data)

    expected_summaries = [
      "#{test_dir}/test_file_1.txt: Test content for file 1.",
      "#{test_dir}/test_file_2.txt: Test content for file 2."
    ]

    expect(summaries).to eq(expected_summaries)
    expect(File).to exist("#{test_dir}/test_file_1.txt")
    expect(File).to exist("#{test_dir}/test_file_2.txt")
  end
end
