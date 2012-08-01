require 'knife-remotelxc/helpers'

module RemoteLXC
  class RemotelxcCreate < Chef::Knife

    include RemoteLXC::Helpers

    deps do
      Chef::Knife::Bootstrap.load_deps
    end

    banner 'knife remotelxc create NODE_NAME'

    option :lxc_node,
      :short => '-l FQDN|IP',
      :long => '--lxc-node FQDN|IP',
      :description => 'LXC enabled node',
      :required => true

    option :lxc_ssh_user,
      :short => '-X USERNAME',
      :long => '--lxc-ssh-user USERNAME'

    # TODO: Pass auth
    #option :lxc_ssh_password,
    #  :short => '-S PASSWORD',
    #  :long => '--lxc-ssh-password PASSWORD'

    # All the bootstrap options since we just proxy
    option :ssh_user,
      :short => "-x USERNAME",
      :long => "--ssh-user USERNAME",
      :description => "The ssh username",
      :default => "ubuntu"

    option :ssh_password,
      :short => "-P PASSWORD",
      :long => "--ssh-password PASSWORD",
      :description => "The ssh password",
      :default => "ubuntu"

    option :ssh_port,
      :short => "-p PORT",
      :long => "--ssh-port PORT",
      :description => "The ssh port",
      :default => "22",
      :proc => Proc.new { |key| Chef::Config[:knife][:ssh_port] = key }

    option :ssh_gateway,
      :short => "-G GATEWAY",
      :long => "--ssh-gateway GATEWAY",
      :description => "The ssh gateway",
      :proc => Proc.new { |key| Chef::Config[:knife][:ssh_gateway] = key }

    option :identity_file,
      :short => "-i IDENTITY_FILE",
      :long => "--identity-file IDENTITY_FILE",
      :description => "The SSH identity file used for authentication"

    option :prerelease,
      :long => "--prerelease",
      :description => "Install the pre-release chef gems"

    option :bootstrap_version,
      :long => "--bootstrap-version VERSION",
      :description => "The version of Chef to install",
      :proc => lambda { |v| Chef::Config[:knife][:bootstrap_version] = v }

    option :bootstrap_proxy,
      :long => "--bootstrap-proxy PROXY_URL",
      :description => "The proxy server for the node being bootstrapped",
      :proc => Proc.new { |p| Chef::Config[:knife][:bootstrap_proxy] = p }

    option :use_sudo,
      :long => "--sudo",
      :description => "Execute the bootstrap via sudo",
      :boolean => true

    option :template_file,
      :long => "--template-file TEMPLATE",
      :description => "Full path to location of template to use",
      :default => false

    option :run_list,
      :short => "-r RUN_LIST",
      :long => "--run-list RUN_LIST",
      :description => "Comma separated list of roles/recipes to apply",
      :proc => lambda { |o| o.split(/[\s,]+/) },
      :default => []

    option :first_boot_attributes,
      :short => "-j JSON_ATTRIBS",
      :long => "--json-attributes",
      :description => "A JSON string to be added to the first run of chef-client",
      :proc => lambda { |o| JSON.parse(o) },
      :default => {}

    option :host_key_verify,
      :long => "--[no-]host-key-verify",
      :description => "Verify host key, enabled by default.",
      :boolean => true,
      :default => true


    attr_reader :lxc_name

    def initialize(*args)
      super
      config[:distro] = 'chef-full'
    end

    def run
      @lxc_name = config[:chef_node_name] = name_args.first
      ip_address = create_new_container
      bootstrap_container(ip_address)
    end

    private

    def lxc_base
      config[:lxc_node]
    end

    def create_new_container
      knife_ssh(lxc_base, "sudo /usr/local/bin/knife-lxc create #{lxc_name}").stdout.to_s.split(':').last.to_s.strip
    end

    def bootstrap_container(ip_address)
      bootstrap = Chef::Knife::Bootstrap.new
      bootstrap.config = config
      bootstrap.name_args = [ip_address]
      bootstrap.run
    end

  end
end
