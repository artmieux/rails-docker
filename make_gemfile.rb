require 'json'

begin
  config = JSON.parse(File.read('config.json'))
rescue Errno::ENOENT
  abort "Error: config.json not found."
rescue JSON::ParserError => e
  abort "Error: invalid JSON in config.json: #{e.message}"
end

ruby_version = config['RUBY_VERSION'] || ''
rails_version = config['RAILS_VERSION'] || ''

gemfile_content = "source 'https://rubygems.org'\n\n"

gemfile_content << "ruby '#{ruby_version}'\n" unless ruby_version.empty?
gemfile_content << "gem 'rails'"
gemfile_content << ", '#{rails_version}'" unless rails_version.empty?
gemfile_content << "\n"

File.write('Gemfile', gemfile_content)

puts 'Gemfile created successfully!'
