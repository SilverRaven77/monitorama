require 'down'
require 'rbst'

SCHEDULER.every '30s', :first_in => 0  do |job|
    tempfile = Down.download("http://manual.quaive.net/towncrier.md")
    file_data = tempfile.read
    formatted = RbST.new(file_data).to_html
    # formatted = restructuredText.format(file_data)
    send_event('changelog',  { :file_data => formatted} )
end



# send_event('weather', { :temp => temp.to_i.to_s + '°C',
# :condition => desc.capitalize(),
# :title => data['name'],
# :climacon => climacon_class(icon)})

# send_event('convergence', points: points)