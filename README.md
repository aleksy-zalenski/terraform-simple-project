In ansible make sure to disable host key checks otherwise you are gonna have a bad time
/etc/ansible/ansible.cfg
[defaults]
host_key_checking = False
Also add your aws key to the ssh-agent
ssh-add aws_access_key
