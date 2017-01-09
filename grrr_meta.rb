require 'rsclass'
require 'tmpdir'

module GrrrMeta
	class <<self
		def execute(operation, defname)
			ensure_editor_environment_variable_is_set
	
			repo_entry = parse_def_arg(defname)
			rest_of_repo = []
			
			case operation
			when "generate"
				generate(repo_entry, rest_of_repo, [:rb_stub, :sc_stub])
			when "generate-rb"
				generate(repo_entry, rest_of_repo, [:rb_stub])
			when "generate-sc"
				generate(repo_entry, rest_of_repo, [:sc_stub])
			when "workcopyedit-rb"
				workcopyedit_one(repo_entry, rest_of_repo, :rb_stub)
			when "workcopyedit-sc"
				workcopyedit_one(repo_entry, rest_of_repo, :sc_stub)
			when "workcopyedit-both"
				workcopyedit_both(repo_entry, rest_of_repo)
			when "workcopyedit-sidebyside"
				workcopyedit_sidebyside(repo_entry, rest_of_repo)
			when "defedit"
				defedit(repo_entry)
			else
				raise "unknown operation #{operation}"
			end
		end

		def print_usage
			operations = [
				"generate",
				"generate-rb",
				"generate-sc",
				"workcopyedit-rb",
				"workcopyedit-sc",
				"workcopyedit-both",
				"workcopyedit-sidebyside",
				"defedit"
			]
			puts "usage: ruby #{__FILE__} operation [defname]"
			puts "	operation:"
			puts operations.map { |operation| "\t\t#{operation}" }.join("\n")
		end
		def ensure_editor_environment_variable_is_set
			raise "EDITOR environment variable is not set" unless ENV["EDITOR"]
		end

		def ensure_destination_folders_exist
			raise "GRRR_META_RB_DESTINATION_FOLDER environment variable is not set" unless ENV["GRRR_META_RB_DESTINATION_FOLDER"]
			raise "GRRR_META_SC_DESTINATION_FOLDER environment variable is not set" unless ENV["GRRR_META_SC_DESTINATION_FOLDER"]
			raise "GRRR_META_RB_DESTINATION_FOLDER environment variable does not refer to a folder" unless File.directory?(ENV["GRRR_META_RB_DESTINATION_FOLDER"])
			raise "GRRR_META_SC_DESTINATION_FOLDER environment variable does not refer to a folder" unless File.directory?(ENV["GRRR_META_SC_DESTINATION_FOLDER"])
		end

		def generate(repo_entry, rest_of_repo, dest_types)
			ensure_destination_folders_exist
			dest_types.each do |dest_type|
				stub = RSClass.generate(repo_entry, rest_of_repo, dest_type)
				write_n_diff(stub)
			end
		end
		
		def workcopyedit_one(repo_entry, rest_of_repo, dest_type)
			path = get_workcopy_file_path_from_repo(repo_entry, rest_of_repo, dest_type)
			print "\"#{ENV["EDITOR"]} #{File.basename(path)}\"? [Yn] "
			system("#{ENV["EDITOR"]} #{path}") if user_say_yes?
		end
		
		def workcopyedit_both(repo_entry, rest_of_repo)
			rb_path, sc_path = get_rb_and_sc_workcopy_file_paths_from_repo(repo_entry, rest_of_repo)
			print "\"#{ENV["EDITOR"]} #{[rb_path, sc_path].map {|p|File.basename(p)}.join(" ")}\"? [Yn] "
			system("#{ENV["EDITOR"]} #{[rb_path, sc_path].join(" ")}") if user_say_yes?
		end
		
		def workcopyedit_sidebyside(repo_entry, rest_of_repo)
			rb_path, sc_path = get_rb_and_sc_workcopy_file_paths_from_repo(repo_entry, rest_of_repo)
			print "\"#{ENV["EDITOR"]} -O2 #{[rb_path, sc_path].map {|p|File.basename(p)}.join(" ")}\"? [Yn] "
			system("#{ENV["EDITOR"]} -O2 #{[rb_path, sc_path].join(" ")}") if user_say_yes?
		end
		
		def defedit(repo_entry)
			defpath = get_defpath(repo_entry["source"]["name"])
			print "\"#{ENV["EDITOR"]} #{File.basename(defpath)}\"? [Yn] "
			system("#{ENV["EDITOR"]} #{defpath}") if user_say_yes?
		end
		
		def get_rootdir
			File.expand_path(File.dirname(__FILE__))
		end
		
		def get_repodir
			File.join(get_rootdir, "def")
		end
		
		def get_defpath(defname)
			File.join(get_repodir, "#{defname}.rsclass.rb")
		end
		
		def parse_def(filename)
			name, type, format = File.basename(filename).split "."
			file = {
				:source => {
					:name => name,
					:type => type,
					:format => format
				},
				:content => File.read(filename)
			}
			RSClass.parse_file(file)
		end
		
		def parse_def_arg(defname)
			filename = get_defpath(defname)
			if not File.exists?(filename)
				entries = Dir.entries(get_repodir).
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
						exit unless user_say_yes?
						filename = get_defpath(single_match)
					else
						puts "Several matches in repository. Choose:"
						entries.each_with_index { |item, i| puts "#{i+1}. #{item}" }
						filename = get_defpath(
							entries[get_user_number_in_range((1..entries.size))-1]
						)
					end
				end
			end
		
			parse_def(filename)
		end
		
		def write_n_diff(stub)
			dest = stub[:destination]
		
			generated_file_path = get_generated_file_path(dest[:filetype], dest[:filename])
			workcopy_file_path = get_workcopy_file_path(dest[:filetype], dest[:filename])
		
			File.open("#{generated_file_path}", 'w') {|f| f.write(stub[:content])}
			print "stub #{get_destination_language_from_filetype(dest[:filetype])}/#{File.basename(generated_file_path)} generated. diff with workcopy? [Yn] "
			system("#{ENV["EDITOR"]} -d #{generated_file_path} #{workcopy_file_path}") if user_say_yes?
		end
		
		def get_destination_language_from_filetype(destination_filetype)
			case destination_filetype
			when "rb" then "Ruby"
			when "sc" then "SuperCollider"
			else
				raise "unsupported file type"
			end
		end
		
		def get_generated_file_path(destination_filetype, destination_filename)
			dir = File.join(Dir.tmpdir, destination_filetype)
			Dir.mkdir(dir) unless File.directory? dir
			File.join(dir, destination_filename)
		end
		
		def get_workcopy_file_path(destination_filetype, destination_filename)
			File.join(get_workcopy_folder_path(destination_filetype), destination_filename)
		end
		
		def get_workcopy_folder_path(destination_filetype)
			ENV["GRRR_META_#{destination_filetype.upcase}_DESTINATION_FOLDER"]
		end
		
		def get_rb_and_sc_workcopy_file_paths_from_repo(repo_entry, rest_of_repo)
			rb_path = get_workcopy_file_path_from_repo(repo_entry, rest_of_repo, :rb_stub)
			sc_path = get_workcopy_file_path_from_repo(repo_entry, rest_of_repo, :sc_stub)
			[rb_path, sc_path]
		end
		
		def get_workcopy_file_path_from_repo(repo_entry, rest_of_repo, dest_type)
			stub = RSClass.generate(repo_entry, rest_of_repo, dest_type)
			dest = stub[:destination]
			get_workcopy_file_path(dest[:filetype], dest[:filename])
		end
		
		def user_say_yes?
			["y", ""].include?(STDIN.gets.chomp.downcase)
		end

		def get_user_number_in_range(range)
			print "[#{range.min}-#{range.max}] "
			number = STDIN.gets.chomp.to_i
			exit unless range.include? number
			number
		end
	end
end

if $0 == __FILE__
	if ARGV.size == 0
		GrrrMeta.print_usage
	else
		operation = ARGV[0]
		defname = ARGV[1]
		GrrrMeta.execute(operation, defname)
	end
end
