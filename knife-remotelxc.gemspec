$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__)) + '/lib/'
require 'knife-remotelxc/version'
Gem::Specification.new do |s|
  s.name = 'knife-remotelxc'
  s.version = KnifeRemoteLXC::VERSION.version
  s.summary = 'Create LXC nodes'
  s.author = 'Chris Roberts'
  s.email = 'chrisroberts.code@gmail.com'
  s.homepage = 'http://github.com/heavywater/knife-remotelxc'
  s.description = "Remote LXC"
  s.require_path = 'lib'
  s.files = Dir.glob('**/*')
  s.add_dependency 'chef'
end
