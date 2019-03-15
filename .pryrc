#require 'irbtools/more'

#def safe_require(name)
#  begin
#    require name
#  rescue LoadError
#    puts "#{name} not loaded"
#  end
#end
#safe_require 'irbtools/more'

if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end

# Hit Enter to repeat last command
Pry::Commands.command /^$/, "repeat last command" do
  _pry_.run_command Pry.history.to_a.last
end

Pry.config.color = true
Pry.config.theme = "solarized"

begin
  require 'rubygems'
  require 'awesome_print'
  AwesomePrint.pry!
rescue LoadError => err
  puts err
end

def show_sql_queries
  if defined?(Rails)
    ActiveRecord::Base.logger = Logger.new(STDOUT)
  end
end

# CONSTANTS
PST = 'Pacific Time (US & Canada)'

