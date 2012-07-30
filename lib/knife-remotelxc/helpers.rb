module RemoteLXC
  module Helpers
    def knife_ssh(addr, command, args={})
      cmd = "ssh -o StrictHostKeyChecking=no #{"{config[:lxc_ssh_user]}@" if config[:lxc_ssh_user]}#{addr} #{command}"
      so = Mixlib::ShellOut.new(cmd,
        :logger => Chef::Log.logger,
        :live_stream => $stdout
      ).run_command
      so.error!
      so
    end
  end
end
