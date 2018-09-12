Given(/^launch recall after mocking$/) do
  WebMock.after_request do |request_signature, response|
    puts "Request: #{request_signature}"
    puts "Response: #{response.inspect}"
  end
end

Given(/^disable mocking$/) do
  WebMock.disable!
end

Given(/^enable mocking$/) do
  WebMock.enable!
end

Given(/^allow real request while mocking$/) do
  WebMock.allow_net_connect!
end

Given(/^disable real request while mocking$/) do
  WebMock.disable_net_connect!
end
