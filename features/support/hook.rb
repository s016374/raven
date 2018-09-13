require 'pry-byebug'
require 'http'
require 'ruby-jmeter'

World(FactoryBot::Syntax::Methods)

Before do
  FactoryBot.find_definitions
  WebMock.enable!
end

After do |_scenario|
  WebMock.disable!
  report_issue_to_fireman(_scenario.name) unless ENV['FIREMAN_REPORT'].nil?
end

private
# curl -u user:passwd -X 'POST' -d '{error description}' http://fireman_host/issue
# curl -u user:passwd -X 'DELETE' http://fireman_host/issue/issue_id
# curl -u user:passwd -X 'DELETE' http://fireman_host/issues/clean
def report_issue_to_fireman(scenario)
  url = "#{ENV['FIREMAN_HOST']}/issue"
  report = { msg: "[Prism E] scenario: #{scenario}" }
  HTTP.basic_auth(user: ENV['FIREMAN_USER'], pass: ENV['FIREMAN_PASSWORD']).post(url, json: report)
end
