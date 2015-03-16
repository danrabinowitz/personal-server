# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

require_relative 'vagrant_helper'
ensure_plugin_is_installed('vagrant-env')
ensure_plugin_is_installed('vagrant-host-shell')

REQUIRED_ANSIBLE_EXTRA_VARS = %w(OPENVPN_PKI_PASSWORD OPENVPN_NAME OPENVPN_SERVER_IP)
ANSIBLE_EXTRA_VARS = %w(OPENVPN_SUBNET OPENVPN_NETMASK)

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.env.enable
  require_env_values REQUIRED_ANSIBLE_EXTRA_VARS

  # This configuration is for our local box, when we use virtualbox as the provider
  config.vm.provider :virtualbox do |vb, override|
    override.vm.box = "ubuntu/trusty64"
    override.vm.box_url = "https://atlas.hashicorp.com/ubuntu/boxes/trusty64"
    override.vm.network "private_network", ip: ENV['OPENVPN_SERVER_IP']
    vb.gui = false
    vb.memory = 896 # This is 7/8 of a gig of ram
  end

  config.vm.provision :host_shell do |host_shell|
    host_shell.inline = "ansible-galaxy install -r requirements.yml --force"
  end

  config.vm.provision "ansible" do |ansible|
      ansible.playbook = "playbook.yml"

      ansible.extra_vars = {}
      merge_if_present(ansible.extra_vars, REQUIRED_ANSIBLE_EXTRA_VARS + ANSIBLE_EXTRA_VARS)
  end

  completion_message1 = <<-eof
The server is provisioned. Further, your client openvpn config file has been saved to your /tmp directory, along with .crt and .key files. If you are using a
standard OpenVPN install, executing the following command will move these files into place:
 
sudo ./install_vpn_conf_and_keys.sh #{Shellwords.escape(ENV['OPENVPN_NAME'])}
 
Then running the following will start your openvpn client and connect to the openvpn server:
sudo -s 'cd /etc/openvpn && /usr/local/sbin/openvpn --config #{ENV['OPENVPN_NAME']}_client_01.conf'
 
You can then ssh into the newly-provisioned machine through the OpenVPN tunnel with:
ssh -i .vagrant/machines/default/virtualbox/private_key vagrant@10.7.1.1
eof

  config.vm.provision :host_shell do |host_shell|
    host_shell.inline = "echo #{Shellwords.escape(completion_message1)}"
  end

end
