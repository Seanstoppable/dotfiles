#!/usr/bin/ruby
require 'irb/completion'
require 'irb/ext/save-history'
require 'socket'
require 'etc'

def check_time
  start = Time.now
  result = yield
  puts "Completed in #{Time.now - start} seconds."
  result
end

def prompt_format(string)
  base_prompt=""
  hostname = Socket.gethostname
  production_color = "\e[31m"
  dev_color = "\e[32m"
  #if system name does not start with username, assume we are running in production
  production = !hostname.start_with?(Etc.getlogin)
  base_prompt = "\001#{production ? production_color : dev_color}\002#{hostname}:#{string}\001\e[0m\002"
end

IRB.conf[:PROMPT][:CUSTOM] = {
        :PROMPT_I => prompt_format("%03n:%i > "),
        :PROMPT_S => prompt_format("%03n:%i%l "),
        :PROMPT_C => prompt_format("%03n:%i * "),
        :RETURN => prompt_format("%s\n")
}
IRB.conf[:PROMPT_MODE] = :CUSTOM

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "~/.irbhistory"

# load .irbrc_rails in rails environments
railsrc_path = File.expand_path('~/.irbrc_rails')
if ( ENV['RAILS_ENV'] || defined? Rails ) && File.exist?( railsrc_path )
  begin
    load railsrc_path
  rescue Exception
    warn "Could not load: #{ railsrc_path } because of #{$!.message}"
  end
end
