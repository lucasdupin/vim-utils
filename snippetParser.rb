#!/usr/bin/env ruby

require 'rubygems'
require 'plist'

@filename = "snippets"

# Gets the list of filenames to parse
def get_snippets
	#Check if path exists
	path = File.join(ARGV[0], "Snippets");
	if not File.directory? path
		puts "Wrong path given";
		exit(1);
	end


	puts "Looking for snippets in : #{path}";

	#Everything ok, let's create the list
	list = [];
	Dir.new(path).entries.each do |file|
		list << Plist.parse_xml(File.join(path, file)) if file =~ /.tmSnippet$/
	end

	return list
end

def init
	#Get the list of files to parse
	snippets = get_snippets;

	puts "Parsing..."

	result = ""
	snippets.each do |snippet|
		#Find the snippet inside this file
		result << snippet.to_snipMate
	end

	dest = "#{@filename}.snippets"
	File.open(dest, "w+") do |f|
		f.puts result;
	end

	puts "Saving into: #{dest}"

end

class Hash
	def to_snipMate

		#Filename
		@filename = fetch('scope')
		
		#Checking if it is a tabTrigger snippet
		if key? 'tabTrigger'
			#Ok, now let's do the conversion
			content = parseContent

			text = 
############################################################################
"snippet #{fetch('tabTrigger')}
#{content}
"
############################################################################
			return text;
		else
			return ""
		end
	end

	def parseContent
		content = ''
		fetch('content').each_line do |l|
			content += "\t#{l}";
		end;

		content;
	end
end
init()
