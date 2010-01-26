require 'rubygems'
require 'rake'
 
#Files to compile
TARGETS = {
  "Main.as"    => "public/Main.swf",
  "compile.as" => "public/compile.swf"
}
 
EXTRA        = "-use-network=false"
LIBRARY_PATH = "source/swc"
SOURCE_PATH  = "source/classes"
DEBUG        = true
 
 
 
 
 
 
task :default => [ :build ]
task :build do 
  command = "ruby fcshd.rb build "
  TARGETS.each { |k,v|
    command << "\'" + get_compile_line(k, v) + "\' "
  }
  result = system(command)
end
 
def get_compile_line(input, output)
  line = "mxmlc #{File.join(current_path(), SOURCE_PATH, input)} -o=#{File.join(current_path(), SOURCE_PATH, output)} -debug=#{DEBUG} -library-path+=#{File.join(current_path, LIBRARY_PATH)} -sp+=#{File.join(current_path(), SOURCE_PATH)} #{EXTRA}"
end
 
def current_path
  File.expand_path(File.join(__FILE__,"../"))
end
