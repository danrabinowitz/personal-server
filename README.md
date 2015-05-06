TODO:

* Add flag. Unless it is set, do no overwrite OpenVPN config

Do we want to leave open port 80 to allow for updating debian packages? Maybe only to certain IPs?

https://support.ansible.com/hc/en-us/articles/201958037-Reboot-a-server-and-wait-for-it-to-come-back

* Create djr account?

* Should I use my standard ssh keys after initial provisioning?
* Look into how to make sshd more secure
* Improve OpenVPN security - MITM attack
* Improve IPTables security - IPV6

* Lock down ntp hosts in iptables
* Lock down sendgrid smtp hosts

* Try iPhone OpenVPN app
* Make Dropwall not log traffic. Also do not log ssh attempts

# Update the server on EC2
vagrant up --provider=aws
