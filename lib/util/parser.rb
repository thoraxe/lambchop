class Lambchop::Parser
  def selinux_stanzas(file)
    require 'selinux'
    parsed_context = parse_selinux_context(Selinux.lgetfilecon(file)[1])

    dsl = ""
    dsl << "  selrange => #{parsed_context[:selrange]}, \n"
    dsl << "  selrole  => #{parsed_context[:selrole]}, \n"
    dsl << "  seltype  => #{parsed_context[:seltype]}, \n"
    dsl << "  seluser  => #{parsed_context[:seluser]}, \n"
  end

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
