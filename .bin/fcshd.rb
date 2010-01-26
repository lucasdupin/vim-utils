#!/usr/bin/env ruby

require 'webrick'
require 'net/http'
require 'fileutils'

#Running as daemon
require 'rubygems'
require 'daemons'


PORT = 6924
HOST = "localhost"

ASSIGNED_REGEXP = /^ fcsh: Assigned (\d+) as the compile target id/

#remembering wich swfs we asked for compiling
@commands = Hash.new

def start_server

	fcsh = IO.popen("fcsh  2>&1", "w+")
	read_to_prompt(fcsh)

	#Creating the HTTP Server  
	s = WEBrick::HTTPServer.new(
		:Port => PORT,
		:Logger => WEBrick::Log.new(nil, WEBrick::BasicLog::WARN),
		:AccessLog => []
	)

	#giving it an action
	s.mount_proc("/build"){|req, res|

		#response variable
		output = ""

		#Searching for an id for this command
		if @commands.has_key?(req.body)
			# Exists, incremental
			fcsh.puts "compile #{@commands[req.body]}"
			output = read_to_prompt(fcsh)
		else
			# Does not exist, compile for the first time
			fcsh.puts req.body
			output = read_to_prompt(fcsh)
			match = output.scan(ASSIGNED_REGEXP)
			@commands[req.body] = match[0][0]
		end

		res.body = output
		res['Content-Type'] = "text/html"
	}

	s.mount_proc("/exit"){|req, res|
		s.shutdown
		fcsh.close
		exit
	}

	trap("INT"){
		s.shutdown 
		fcsh.close
	}

	#Starting webrick
	puts "\nStarting Webrick at http://#{HOST}:#{PORT}"
	s.start

	# #Do not show error if we're trying to start the server more than once
	# if e.message =~ /Address already in use/ < 0
	#   puts e.message
	# end

end

#Helper method to read output
def read_to_prompt(f)
	f.flush
	output = ""
	while chunk = f.read(1)
		STDOUT.write chunk
		output << chunk
		if output =~ /^\(fcsh\)/
			break
		end
	end
	STDOUT.write ">"
	output
end

def daemon
	Daemons.daemonize
	start_server
end

############################################
# If a parameter was provided, take action #
############################################

def init
	begin
		case ARGV[0]
			#Starts the server
		when "server"
			start_server

			#Starts server as a daemon
		when "daemon"
			daemon
			#Build
		when "build"
			ARGV[1, ARGV.length].each{ |arg|
			# puts arg
			http = Net::HTTP.new(HOST, PORT)
			resp, date = http.post('/build', arg)
			puts resp.body
		}
		exit

		#Tells server to exit
		when "exit"
			http = Net::HTTP.new(HOST, PORT)
			resp, date = http.get('/exit')
			puts resp.body
			exit
		end

		# When asking for the server and it refuses the connectio
		# mainly it's because the service is down
		# soooooo... let's start it!
	rescue Errno::ECONNREFUSED

		exit(1) if ARGV[0] == "exit"

		puts "Server is down... starting it up, run this command again"
		daemon

		#Other errors
	rescue => e
		puts "Invalid command: #{e}"
		exit(1)
	end
end

init()
