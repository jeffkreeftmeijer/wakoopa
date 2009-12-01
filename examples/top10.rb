$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require 'sinatra'
require 'wakoopa'

get '/' do
  
  if params[:username]
    
    Wakoopa.username = params[:username]
    software = Wakoopa::Software.all(:sort => 'active_seconds', :limit => 10)
    
    output = "<h1>Software top 10 for #{params[:username]}</h1>"
    output << '<ol>'
    
    software.each do |app|
      output << '<li>'
      output << "<a href=\"#{app.url}\"><img src=\"#{app.complete_icon_url}\" alt=\"#{app.name}\"/></a>"
      output << '</li>'
    end
    
    output << '</ol>'
    output
    
  else
    
    '<form>' <<
    '<label for="username">Please enter your <a href="http://wakoopa.com">Wakoopa</a> username</label><br/>' <<
    '<input type="text" name="username"/>' <<
    '<input type="submit"/>' <<
    '</form>'
    
  end
  
end