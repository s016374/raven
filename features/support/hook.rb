require 'pry-byebug'
require 'http'
require 'ruby-jmeter'

World(FactoryBot::Syntax::Methods)

Before do
  FactoryBot.find_definitions
  WebMock.enable!
end

After do
  WebMock.disable!
end
