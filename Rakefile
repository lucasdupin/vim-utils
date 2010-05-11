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
task :build do 
  command = "fcshd build "
  TARGETS.each { |k,v|
    command << "\'" + get_compile_line(k, v) + "\' "
  }
  result = system(command)
end
task :open do

  open = File.join(current_path, OPEN)
  open = OPEN unless File.file? open
  system "open '#{open}'"

  filename = File.expand_path('~/Library/Preferences/Macromedia/Flash Player/Logs/flashlog.txt')
  system("tail -f '#{filename}'")

end

def get_compile_line(input, output)

	libs_path    = LIBRARY_PATH.map{ |lib| "-library-path+='#{File.join(current_path, lib)}'"}.join(" ")
	sources_path = SOURCE_PATH.map{ |lib| "-sp+='#{File.join(current_path, lib)}'"}.join(" ")

	line = "mxmlc #{File.join(current_path(), input)} -o=#{File.join(current_path(), output)} -debug=#{DEBUG} #{libs_path} #{sources_path} #{EXTRA}"
end

def current_path
  File.expand_path(File.join(__FILE__,"../"))
end

