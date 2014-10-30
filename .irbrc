def check_time
  start = Time.now
  result = yield
  puts "Completed in #{Time.now - start} seconds."
  result
end

IRB.conf[:PROMPT][:CUSTOM] = {
        :PROMPT_I => "\e[31mPRODUCTION:%03n:%i\e[0m > ",
        :PROMPT_S => "\e[31mPRODUCTION:%03n:%i%l\e[0m  ",
        :PROMPT_C => "\e[31mPRODUCTION:%03n:%i*\e[0m  ",
        :RETURN => "\e[31mPRODUCTION%s\n\e[0m"
}
IRB.conf[:PROMPT_MODE] = :CUSTOM

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "~/.irbhistory"

IRB.conf[:IRB_RC] = Proc.new do
  major_version = Rails.version.first.to_i
  if (major_version == 2)
    ActiveRecord::Base.connection.instance_variable_set :@logger, Logger.new(STDOUT)
  end
end

