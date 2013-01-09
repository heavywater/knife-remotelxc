require 'knife-remotelxc/helpers'

module RemoteLXC
  class RemotelxcDelete < Chef::Knife::Ssh

    include RemoteLXC::Helpers

    banner 'knife remotelxc delete NODE_NAME'

    option :lxc_node,
      :short => '-l FQDN|IP',
      :long => '--lxc-node FQDN|IP',
      :description => 'LXC enabled node',
      :required => true

    option :lxc_ssh_user,
      :short => '-X USERNAME',
      :long => '--lxc-ssh-user USERNAME'
   
    def run
      ui.confirm "Delete LXC node: #{name_args.first}"
      knife_ssh(config[:lxc_node], "knife_lxc delete #{name_args.first}")
    end

  end
end
