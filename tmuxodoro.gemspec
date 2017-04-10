# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tmuxodoro/version'

Gem::Specification.new do |spec|
  spec.name          = "tmuxodoro"
  spec.version       = Tmuxodoro::VERSION
  spec.authors       = ["Timur Yanberdin"]
  spec.email         = ["yanberdint@gmail.com"]

  spec.summary       = "Pomodoro timer for tmux"
  spec.homepage      = "https://github.com/mendab1e/tmuxodoro"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
