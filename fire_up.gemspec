Gem::Specification.new do |s|
  s.name = 'fire_up'
  s.version = '0.1'
  s.author = 'Chris Powers'
  s.date = "2010-03-27"
  s.homepage = 'http://github.com/chrisjpowers/fire_up'
  s.email = 'chrisjpowers@gmail.com'
  s.summary = 'The FlexibleCsv gem uses the FasterCSV gem to parse user created CSV files that may not have standard headers.'
  s.files = ['README.rdoc', 'CHANGELOG.rdoc', 'LICENSE', 'lib/fire_up.rb']
  s.require_paths = ["lib"]
  s.bindir = 'bin'
  s.has_rdoc = true
  s.add_dependency('iterm_window', '>= 0.3.3')
end
