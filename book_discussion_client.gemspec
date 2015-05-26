require './lib/book_discussion_client/version'

Gem::Specification.new do |spec|
  spec.name          = 'book_discussion_client'
  spec.version       = BookDiscussionClient::VERSION
  spec.authors       = ["Michael Smedberg"]
  spec.email         = ["msmedberg@zendesk.com"]
  spec.summary       = %q{ Book Discussion ruby client }
  spec.description   = %q{ A book discussion service client. }
  spec.homepage      = ''
  spec.license       = 'PRIVATE'

  spec.metadata['allowed_push_host'] = "https://gem.zdsys.com/gems/"

  spec.files         = Dir.glob('{lib,schemas}/**/*')
  spec.executables   = Dir.glob('bin/**/*').map {|f| File.basename(f)}

  spec.add_runtime_dependency "activemodel"
  spec.add_dependency "faraday", "~> 0.9"
  spec.add_dependency "faraday_middleware", "~> 0.9"

  spec.add_development_dependency 'private_gem'
  spec.add_dependency "avro_turf", "~> 0.1.1"
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'minitest'
end
