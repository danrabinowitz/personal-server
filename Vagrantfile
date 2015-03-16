# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

require_relative 'vagrant_helper'
ensure_plugin_is_installed('vagrant-env')

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

  config.vm.provision "shell", inline: "ansible-galaxy install -r requirements.yml --force"

  config.vm.provision "ansible" do |ansible|
      ansible.playbook = "playbook.yml"

      ansible.extra_vars = {}
      merge_if_present(ansible.extra_vars, REQUIRED_ANSIBLE_EXTRA_VARS + ANSIBLE_EXTRA_VARS)
  end

  completion_message1 = <<-eof
The server is provisioned. Further, your client openvpn config file has been
saved to your /tmp directory, along with .crt and .key files. If you are using a
standard OpenVPN install, executing the following commands *as root* will move
these files into place:
mv /tmp/#{ENV['OPENVPN_NAME']}_client_01.conf /etc/openvpn && chown root:wheel /etc/openvpn/#{ENV['OPENVPN_NAME']}_client_01.conf && chmod 644 /etc/openvpn/#{ENV['OPENVPN_NAME']}_client_01.conf
mv /tmp/#{ENV['OPENVPN_NAME']}_client_01.key /etc/openvpn/keys && chown root:wheel /etc/openvpn/keys/#{ENV['OPENVPN_NAME']}_client_01.key && chmod 400 /etc/openvpn/keys/#{ENV['OPENVPN_NAME']}_client_01.key
mv /tmp/#{ENV['OPENVPN_NAME']}_client_01.crt /etc/openvpn/keys && chown root:wheel /etc/openvpn/keys/#{ENV['OPENVPN_NAME']}_client_01.crt && chmod 444 /etc/openvpn/keys/#{ENV['OPENVPN_NAME']}_client_01.crt
eof
  completion_message2 = <<-eof
Then running the following as root will start your openvpn client and connect to the openvpn server:
cd /etc/openvpn && /usr/local/sbin/openvpn --config #{ENV['OPENVPN_NAME']}_client_01.conf
 
You can then ssh into the newly-provisioned machine through the OpenVPN tunnel with:
ssh -i .vagrant/machines/default/virtualbox/private_key vagrant@10.7.1.1
eof

  config.vm.provision "shell", inline: "echo #{Shellwords.escape(completion_message1)}"
  config.vm.provision "shell", inline: "echo #{Shellwords.escape(completion_message2)}"

end
