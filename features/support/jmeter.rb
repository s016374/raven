require 'ruby-jmeter'

class RubyJmeter::ExtendedDSL
  def do_with_my_config
    if ENV['JMETER_PATH'].nil?
      p 'ninininini'
      jmx(
        file: "jmeter.jmx"
      )
    else
      run(
        path: ENV['JMETER_PATH'],
        file: 'ruby-jmeter.jmx',
        log: 'jmeter.log',
        jtl: ENV['JMETER_JTL'],
        properties: 'jmeter.properties',
        gui: ENV['JMETER_GUI'] || false
      )
    end
  end
end
