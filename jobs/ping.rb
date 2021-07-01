require 'net/ping'

def theping(host)
    check = Net::Ping::External.new(host)
    check.ping?
end

$ping_variable = 10
class Class1
    def print_global
        puts "Global variable in Class1 is #$ping_variable"
    end
end
class Class2
    def print_global
        puts "Global variable in Class2 is #$ping_variable"
    end
end

class1obj = Class1.new
class1obj.print_global
class2obj = Class2.new
class2obj.print_global

settings = YAML.load_file(File.join(File.expand_path('./.'), 'config.yml'))
tirs_settings = settings['ping']

settings['ping'].each do |_id, host|
    SCHEDULER.every '1s', :first_in => 0  do
        status = theping(host['ip']) ? "green" : "red"
        send_event("ping_#{_id}", {status: status, host: host['ip'], hostname: host['name']})
    end
end