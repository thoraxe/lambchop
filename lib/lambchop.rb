module Lambchop

  require 'util/parser'

  def self.dsl(file, opts = {})

    if opts[:selinux] == true
      use_selinux = true
    end

    # test if accidentally supplied a directory
    if File.directory?(file)
      raise ArgumentError, "Sorry, that's a directory, not a file"
    else

      # grab the stat of the file
      stat = File::Stat.new(file)

      # begin to build the DSL
      dsl = ""

      dsl << "file { '#{file}': \n"

      dsl << "  ensure => present, \n"
      dsl << "  owner  => #{stat.uid}, \n"
      dsl << "  group  => #{stat.gid}, \n"
      dsl << "  mode   => #{sprintf("%o", stat.mode)[-4,4]}, \n"

      # should we insert selinux stanzas?
      if use_selinux
	dsl << Lambchop::Parser.selinux_stanzas(file)
      end

      # insert the file contents
      dsl << "  content => \""
      File.readlines(file).each do |line|
              dsl << line
      end

      dsl << "\", \n"

      dsl << "}"

      return dsl
    end
  end

end
