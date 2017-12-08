#require 'irb/completion'
#require 'irbtools'

def safe_require(name)
  begin
    require name
  rescue LoadError
    puts "#{name} not loaded"
  end
end

safe_require 'irbtools/more'

IRB.conf[:SAVE_HISTORY] ||= 1000
IRB.conf[:HISTORY_FILE] ||= File.join(ENV["HOME"], ".irb-history")
IRB.conf[:AUTO_INDENT] = true

#if defined?(Rails::Console)
if defined?(Rails)
	ActiveRecord::Base.logger = Logger.new(STDOUT)
  Rails.application.eager_load!
	def show_routes
		all_routes = Rails.application.routes.routes
		require 'action_dispatch/routing/inspector'
		inspector = ActionDispatch::Routing::RoutesInspector.new(all_routes)
		puts inspector.format(ActionDispatch::Routing::ConsoleFormatter.new, ENV['CONTROLLER'])
	end
end

# Benchmark block of code
def benchmark
	# From http://blog.evanweaver.com/articles/2006/12/13/benchmark/
	# Call benchmark { } with any block and you get the wallclock runtime
	# as well as a percent change + or - from the last run
	cur = Time.now
	result = yield
	print "#{cur = Time.now - cur} seconds"
	puts " (#{(cur / $last_benchmark * 100).to_i - 100}% change)" rescue puts ""
	$last_benchmark = cur
	result
end

# Copy string to clipboard
def pbcopy(str)
  IO.popen('pbcopy', 'w') { |f| f << str.to_s }
end

# CONSTANTS
PST = 'Pacific Time (US & Canada)'

