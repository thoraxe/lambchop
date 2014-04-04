class Lambchop < Thor
  desc "dsl FILE", "generate puppet DSL for FILE"

  method_option :selinux, :aliases => "-Z", :desc => "include SELinux information", :type => :boolean, :default => false

  def dsl(file)
    use_selinux = options[:selinux]

    #puts "File to generate DSL for: #{file}"

    # test if accidentally supplied a directory
    if File.directory?(file)
      puts "Sorry, that's a directory, not a file"
      exit 1
    end

    # grab the stat of the file
    stat = File::Stat.new(file)

    # begin to build the DSL
    dsl = ""

    dsl << "file { '#{file}': \n"

    dsl << "  ensure => present, \n"
    dsl << "  owner  => #{stat.uid}, \n"
    dsl << "  group  => #{stat.gid}, \n"
    dsl << "  mode   => #{sprintf("%o", stat.mode)[-4,4]}, \n"

    # if they asked for selinux include that stuff
    if use_selinux
      require 'selinux'
      parsed_context = parse_selinux_context(Selinux.lgetfilecon(file)[1])

      dsl << "  selrange => #{parsed_context[:selrange]}, \n"
      dsl << "  selrole  => #{parsed_context[:selrole]}, \n"
      dsl << "  seltype  => #{parsed_context[:seltype]}, \n"
      dsl << "  seluser  => #{parsed_context[:seluser]}, \n"
    end

    # insert the file contents
    dsl << "  content => \""
    File.readlines(file).each do |line|
	    dsl << line
    end

    dsl << "\", \n"

    dsl << "}"
    puts dsl
  end

  protected

  def parse_selinux_context(context)

    if context.nil? or context == "unlabeled"
      return nil
    end

    unless context =~ /^([a-z0-9_]+):([a-z0-9_]+):([a-zA-Z0-9_]+)(?::([a-zA-Z0-9:,._-]+))?/
      raise ArgumentError, "Context doesn't seem real. #{context}"
    end

    ret = {
      :seluser => $1,
      :selrole => $2,
      :seltype => $3,
      :selrange => $4,
    }
    ret
  end

end
