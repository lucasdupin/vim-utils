#!/usr/bin/env ruby
require 'webrick'
require 'net/http'
require 'fileutils'
#require 'debug'

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

    # #Run
    # if output =~ /^.*\.swf \(\d+ bytes\)/ > 0
    #   `open #{ARGV[2].gsub(' ', '\ ')}` if ARGV[2]
    # end

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

############################################
# If a parameter was provided, take action #
############################################

def init
  begin
    case ARGV[0]
    when "server"
      start_server()
    when "build"
      ARGV[1, ARGV.length].each{ |arg|
        # puts arg
        http = Net::HTTP.new(HOST, PORT)
        resp, date = http.post('/build', arg)
        puts resp.body
      }
      exit
    when "exit"
      http = Net::HTTP.new(HOST, PORT)
      resp, date = http.get('/exit')
      puts resp.body
      exit
    end
  rescue Errno::ECONNREFUSED
    puts "Server is down... start it up"
    exit(2)
    # system("ruby #{__FILE__} server &")
    # sleep(5)
    # init()
  rescue => e
    puts "Invalid command: #{e}"
    exit(1)
  end
end

init()