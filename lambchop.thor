class Lambchop < Thor
  desc "dsl FILE", "generate puppet DSL for FILE"

  def dsl(file)
    #puts "File to generate DSL for: #{file}"

    # test if accidentally supplied a directory
    if File.directory?(file)
      puts "Sorry, that's a directory, not a file"
      exit 1
    end

    # grab the stat of the file
    stat = File::Stat.new(file)
    #puts "Stat: #{stat}"

    dsl = ""

    dsl << "file { '#{file}': \n"

    dsl << "  ensure => present, \n"
    dsl << "  owner  => #{stat.uid}, \n"
    dsl << "  group  => #{stat.gid}, \n"
    dsl << "  mode   => #{sprintf("%o", stat.mode)[-4,4]}, \n"

    # insert the contents

    dsl << "  content => \""
    File.readlines(file).each do |line|
	    dsl << line
    end

    dsl << "\","
    dsl << "}"
    puts dsl
  end

end
