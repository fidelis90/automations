# Ansible Tips

## How does Ansible communicate with target instances
Ansible use SSH to connect, there are 2 types of SSH authentication
Username and Password
SSH Keys(Public and Private): This is the most preferred way we like to connect, since we don't need to be prompted to give password for ansible runs to be successful.

## How does Ansible get configurations
Ansible uses a configuration file always located in the /etc/ansible/ansible.cfg (for linux systems); path can be different depending on the control Host.

```
# sample ansible.cfg file

[defaults]
host_key_checking = false
remote_user = ec2-user
ask_pass = false
private_key_file = /root/aws-ansible/webkey.pem
roles_path = /root/aws-ansible/roles

[privilege_escalation]
become = true
become_method = sudo
become_user = root
become_ask_pass = false
```
> HINT: You can paste this cfg in CHAT-GPT and it will explain what each line does,  and can even stretch further to ask the AI bot to give your more ansible cfg atributes