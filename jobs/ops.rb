# :first_in sets how long it takes before the job is first run. In this case, it is run immediately

require 'net/ping'

def theping(host)
    check = Net::Ping::External.new(host)
    check.ping?
end

SCHEDULER.every '1s', :first_in => 0 do |job|
  send_event('response_time_1', { value: theping("127.0.0.1") })
  send_event('response_time_2', { value: rand(400) })
end