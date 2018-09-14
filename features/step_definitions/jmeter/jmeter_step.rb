When(/^jmeter (get|post) '(.*)'$/) do |http_method, api|
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
