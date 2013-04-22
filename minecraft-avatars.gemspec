# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'minecraft-avatars/version'

Gem::Specification.new do |spec|
  spec.name          = "minecraft-avatars"
  spec.version       = MinecraftAvatars::VERSION
  spec.authors       = ["Jacob Jervey"]
  spec.email         = ["jacob.jervey@gmail.com"]
  spec.description   = %q{Ruby gem for retrieving Minecraft skins and returning them in a variety of sizes and formats}
  spec.summary       = %q{Minecraft skin API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rmagick", "~> 2.13.2"
  spec.add_development_dependency "chunky_png", "~> 1.2.8"
end
