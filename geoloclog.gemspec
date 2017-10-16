Gem::Specification.new do |s|
  s.name = 'geoloclog'
  s.version = '0.1.4'
  s.summary = 'Logs geolocated placenames as well as coordinates ' +
      'in reverse chronological order.'
  s.authors = ['James Robertson']
  s.files = Dir['lib/geoloclog.rb']
  s.add_runtime_dependency('glw', '~> 0.2', '>=0.2.2')   
  s.add_runtime_dependency('dynarex-daily', '~> 0.3', '>=0.3.0') 
  s.signing_key = '../privatekeys/geoloclog.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@jamesrobertson.eu'
  s.homepage = 'https://github.com/jrobertson/geoloclog'
end
