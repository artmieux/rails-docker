require 'json'

# Read the JSON file
config = JSON.parse(File.read('config.json'))

ruby_version = config['RUBY_VERSION']
rails_version = config['RAILS_VERSION']

# Generate the Gemfile content
gemfile_content = "source 'https://rubygems.org'\n\n"

gemfile_content << "ruby '#{ruby_version}'\n" unless ruby_version.empty?
gemfile_content << "gem 'rails'"
gemfile_content << ", '#{rails_version}'" unless rails_version.empty?
gemfile_content << "\n"

# Write the Gemfile
File.write('Gemfile', gemfile_content)

puts 'Gemfile created successfully!'
