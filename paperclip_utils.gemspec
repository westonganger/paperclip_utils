lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'paperclip_utils/version.rb'

Gem::Specification.new do |s|
  s.name        = 'paperclip_utils'
  s.version     =  PaperclipUtils::VERSION
  s.author	= "Weston Ganger"
  s.email       = 'weston@westonganger.com'
  s.homepage 	= 'https://github.com/westonganger/paperclip_utils'
  
  s.summary     = "Helper class for easier dynamic processors and styles on your Paperclip uploads"
  s.description = "Helper class for easier dynamic processors and styles on your Paperclip uploads"
  s.files = Dir.glob("{lib/**/*}") + %w{ LICENSE README.md Rakefile CHANGELOG.md }
  s.test_files  = Dir.glob("{test/**/*}")

  s.add_runtime_dependency 'paperclip', '>= 3.0'
  
  s.add_development_dependency 'rake'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'activerecord'

  s.required_ruby_version = '>= 2.0.0'
  s.require_path = 'lib'
end
