require 'knife-remotelxc/helpers'

module RemoteLXC
  class RemotelxcInfo < Chef::Knife::Ssh

    include RemoteLXC::Helpers

    banner 'knife remotelxc info NODE_NAME'

    option :lxc_node,
      :short => '-l FQDN|IP',
      :long => '--lxc-node FQDN|IP',
      :description => 'LXC enabled node',
      :required => true

    option :lxc_ssh_user,
      :short => '-X USERNAME',
      :long => '--lxc-ssh-user USERNAME'
   
    def run
      knife_ssh(config[:lxc_node], "knife_lxc info #{name_args.first}")
    end

  end
end
