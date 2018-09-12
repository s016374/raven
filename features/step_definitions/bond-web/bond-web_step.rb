Given(/^mocking '(.*)'$/) do |api|
  next if ENV['IS_MOCK'].nil?
  case
  when api.include?('analysis/pdRank/indus')
    mock_url = ENV['BASE_URL'] + api
    mock_response = {status: 200, body: '{"code": "0", "message": "success", "data": {"content": "conetent from mock"}}'}
    stub_request(:get, mock_url).with(headers: { userid: 52521 }).to_return(mock_response)
  else
    raise "API: #{api} is not defined !"
  end

end

When(/^(get|post) '(.*)'$/) do |http_method, url|
  uri = URI.parse(ENV['BASE_URL'] + url)
  begin
    @res = HTTP[userid: 52521].send(http_method, uri)
  rescue WebMock::NetConnectNotAllowedError
    puts 'E: WebMock::NetConnectNotAllowedError'
    puts 'Mock issue'
  rescue HTTP::Request::UnsupportedSchemeError
    puts 'E: HTTP::Request::UnsupportedSchemeError'
    puts 'URI issue'
  end
end

Then(/^check '(.*)'$/) do |api|
  case
  when api.include?('analysis/pdRank/indus')
    expect(@res.code).to eq(200)
    expect(@res.body.to_s).to include('success')
  else
    raise "API: #{api} is not defined !"
  end
end

And(/^jmeter (get|post) '(.*)'$/) do |http_method, api|
  next unless ENV['IS_MOCK'].nil?
  case
  when api.include?('analysis/pdRank/indus')
    test do
      threads count: ENV['JMETER_COUNT'].to_i, rampup: ENV['JMETER_RAMPUP'].to_i, loops: ENV['JMETER_LOOPS'].to_i do
        transaction name: "#{api}", parent: false do
          header [{ name: 'userid', value: 52521 }]
          self.send(http_method, name: "jmeter #{api}", url: ENV['BASE_URL'] + api)
        end
      end
    end.do_with_my_config
  else
    raise "API: #{api} is not defined !"
  end
end
