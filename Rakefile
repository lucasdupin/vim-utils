require 'rubygems'
require 'rake'

#Files to compile
TARGETS = {
  "source/classes/Main.as"    => "publicMain.swf",
  "source/classes/Compile.as" => "public/Compile.swf"
}
#extra options
EXTRA   = "-use-network=false "
#SWCs
LIBRARY_PATH = [
	"source/swc"
]
#source files
SOURCE_PATH  = [
	"source/classes",
	"source/libs"
]
#Debug symbols
DEBUG   = true

#File to open
OPEN    = "public/index_local.html"

#
#
# Do not change the lines below
#
#
task :default => [ :build ]

# Incremental build
task :build do 
  
  # Default build command
  command = "fcshd build "
  # Generate command to build each file
  TARGETS.each { |k,v|
    command << "\'" + get_compile_line(k, v) + "\' "
  }
  # Build them
  result = system(command)
end

# open project
task :open do

  # Try to get the absolute path
  open = File.join(current_path, OPEN)
  # Mybe it doesn't exist because it's an URI?
  open = OPEN unless File.file? open
  # Open it
  system "open '#{open}'"

  # Watch for traces
  filename = File.expand_path('~/Library/Preferences/Macromedia/Flash Player/Logs/flashlog.txt')
  system("tail -f '#{filename}'")

end

# Building an mxmlc line
def get_compile_line(input, output)

	libs_path    = LIBRARY_PATH.map{ |lib| "-library-path+='#{File.join(current_path, lib)}'"}.join(" ")
	sources_path = SOURCE_PATH.map{ |lib| "-sp+='#{File.join(current_path, lib)}'"}.join(" ")

	line = "mxmlc #{File.join(current_path(), input)} -o=#{File.join(current_path(), output)} -debug=#{DEBUG} #{libs_path} #{sources_path} #{EXTRA}"
end

# Get the current path
def current_path
  File.expand_path(File.join(__FILE__,"../"))
end

