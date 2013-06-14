require 'rsclass'

def grrr_meta_user_say_yes?
	["y", ""].include?(STDIN.gets.chomp.downcase)
end

def grrr_meta_get_user_number_in_range(range)
	print "[#{range.min}-#{range.max}] "
	number = STDIN.gets.chomp.to_i
	exit unless range.include? number 
	number
end

def grrr_meta_get_rootdir
	File.expand_path(File.dirname(__FILE__))
end

def grrr_meta_get_repodir
	"#{grrr_meta_get_rootdir}/def"
end

def grrr_meta_get_defpath(defname)
	"#{grrr_meta_get_repodir}/#{defname}.rsclass.rb"
end

def grrr_meta_parse_def(filename)
	name, type, format = File.basename(filename).split "."
	file = {
		:source => {
			:name => name,
			:type => type,
			:format => format
		},
		:content => File.read(filename)
	}
	parse_file(file)
end

def grrr_meta_parse_def_arg(defname)
	filename = grrr_meta_get_defpath(defname)
	if not File.exists?(filename)
		entries = Dir.entries(grrr_meta_get_repodir).
			reject{|p|%w{. ..}.include?(p)}.
			map {|p|p.split(".")[0]}.
			select{|p|/#{defname}/ =~ p}

		if entries.size == 0
			puts "Argument matched no definition in repository."
			exit
		else
			if entries.size == 1
				single_match = entries.first
				print "You meant \"#{single_match}\", right? [Yn] "
				exit unless grrr_meta_user_say_yes?
				filename = grrr_meta_get_defpath(single_match)
			else
				puts "Several matches in repository. Choose:"
				entries.each_with_index { |item, i| puts "#{i+1}. #{item}" }
				filename = grrr_meta_get_defpath(
					entries[grrr_meta_get_user_number_in_range((1..entries.size))-1]
				)
			end
		end
	end

	grrr_meta_parse_def(filename)
end

def grrr_meta_write_n_diff(stub)
	dest = stub[:destination]
	rootdir = grrr_meta_get_rootdir
	relpath = "#{dest[:directory]}/#{dest[:filename]}"
	gen_fname = "#{rootdir}/tmp/#{relpath}"
	workcopy_fname = "#{grrr_meta_get_workcopy_path(rootdir, dest[:directory])}/#{dest[:filename]}"
	File.open("#{gen_fname}", 'w') {|f| f.write(stub[:content])}
	print "file \"#{relpath}\" generated. diff with workcopy? [Yn] "
	system("#{ENV["EDITOR"]} -d #{gen_fname} #{workcopy_fname}") if grrr_meta_user_say_yes?
end

def grrr_meta_get_workcopy_path(rootdir, destination_filetype)
	path = rootdir + "\\" + destination_filetype
	if File.directory?(path)
		path
	elsif File.file?(path)
		path_in_file = IO.read(path).chomp
		if File.directory?(path_in_file)
			path_in_file
		end
	else
		raise "File #{path} does not exist"
	end or raise "Unable to determine work directory"
end

def grrr_meta_get_relpath(repo_entry, rest_of_repo, dest_type)
	stub = generate(repo_entry, rest_of_repo, dest_type)
	dest = stub[:destination]
	"#{dest[:directory]}/#{dest[:filename]}"
end

def grrr_meta_get_rb_and_sc_relpaths(repo_entry, rest_of_repo)
	rb_relpath = grrr_meta_get_relpath(repo_entry, rest_of_repo, :rb_stub)
	sc_relpath = grrr_meta_get_relpath(repo_entry, rest_of_repo, :sc_stub)
	[rb_relpath, sc_relpath]
end

def grrr_meta_generate(repo_entry, rest_of_repo, dest_types)
	dest_types.each do |dest_type|
		stub = generate(repo_entry, rest_of_repo, dest_type)
		grrr_meta_write_n_diff(stub)
	end
end

def grrr_meta_stubedit_rb(repo_entry, rest_of_repo)
	grrr_meta_stubedit_one(repo_entry, rest_of_repo, :rb_stub)
end

def grrr_meta_stubedit_sc(repo_entry, rest_of_repo)
	grrr_meta_stubedit_one(repo_entry, rest_of_repo, :sc_stub)
end

def grrr_meta_stubedit_one(repo_entry, rest_of_repo, dest_type)
	relpath = grrr_meta_get_relpath(repo_entry, rest_of_repo, dest_type)
	print "\"#{ENV["EDITOR"]} #{File.basename(relpath)}\"? [Yn] "
	system("#{ENV["EDITOR"]} #{grrr_meta_get_rootdir}/#{relpath}") if grrr_meta_user_say_yes?
end

def grrr_meta_stubedit_both(repo_entry, rest_of_repo)
	rb_relpath, sc_relpath = grrr_meta_get_rb_and_sc_relpaths(repo_entry, rest_of_repo)
	print "\"#{ENV["EDITOR"]} #{[rb_relpath, sc_relpath].map {|p|File.basename(p)}.join(" ")}\"? [Yn] "
	system("#{ENV["EDITOR"]} #{[rb_relpath, sc_relpath].map {|p|"#{grrr_meta_get_rootdir}/#{p}"}.join(" ")}") if grrr_meta_user_say_yes?
end

def grrr_meta_stubedit_sidebyside(repo_entry, rest_of_repo)
	rb_relpath, sc_relpath = grrr_meta_get_rb_and_sc_relpaths(repo_entry, rest_of_repo)
	print "\"#{ENV["EDITOR"]} -O2 #{[rb_relpath, sc_relpath].map {|p|File.basename(p)}.join(" ")}\"? [Yn] "
	system("#{ENV["EDITOR"]} -O2 #{[rb_relpath, sc_relpath].map {|p|"#{grrr_meta_get_rootdir}/#{p}"}.join(" ")}") if grrr_meta_user_say_yes?
end

def grrr_meta_defedit(repo_entry)
	defpath = grrr_meta_get_defpath(repo_entry["source"]["name"])
	print "\"#{ENV["EDITOR"]} #{File.basename(defpath)}\"? [Yn] "
	system("#{ENV["EDITOR"]} #{defpath}") if grrr_meta_user_say_yes?
end

def grrr_ensure_editor_environment_variable_is_set
	raise "EDITOR environment variable is not set" unless ENV["EDITOR"]
end

if $0 == __FILE__
	grrr_ensure_editor_environment_variable_is_set
	
	if ARGV.size == 0
		operations = [
			"generate",
			"generate-rb",
			"generate-sc",
			"stubedit-rb",
			"stubedit-sc",
			"stubedit-both",
			"stubedit-sidebyside",
			"defedit"
		]
		puts "usage: ruby #{__FILE__} operation [defname]"
		puts "	operation:"
		puts operations.map { |operation| "\t\t#{operation}" }.join("\n")
	else
		operation = ARGV[0]
		defname = ARGV[1]
		
		repo_entry = grrr_meta_parse_def_arg(defname)
		rest_of_repo = []
		
		case operation
		when "generate"
			grrr_meta_generate(repo_entry, rest_of_repo, [:rb_stub, :sc_stub])
		when "generate-rb"
			grrr_meta_generate(repo_entry, rest_of_repo, [:rb_stub])
		when "generate-sc"
			grrr_meta_generate(repo_entry, rest_of_repo, [:sc_stub])
		when "stubedit-rb"
			grrr_meta_stubedit_rb(repo_entry, rest_of_repo)
		when "stubedit-sc"
			grrr_meta_stubedit_sc(repo_entry, rest_of_repo)
		when "stubedit-both"
			grrr_meta_stubedit_both(repo_entry, rest_of_repo)
		when "stubedit-sidebyside"
			grrr_meta_stubedit_sidebyside(repo_entry, rest_of_repo)
		when "defedit"
			grrr_meta_defedit(repo_entry)
		else
			raise "unknown operation #{operation}"
		end
	end
end
