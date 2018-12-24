# Terraform and Ansible Basic Infrastructure configuration

## Requirments

#### In order to run the application you need the following things:

* AWS Account with API users and it's credentials which you specify in the credentials.tfvars file (There is also a possibility of using defaults ~/.aws/credentials file)
* SSH key pair generated which path you specify in teh terraform.tfvars file
* Terraform + Ansible Installed on your machine

### Confiugration

All you need to do is populate the terraform.tfvars file with your credentials data and the SSH key-pair paths. The content of the file should look similar to this:

```
ssh_public_key_path = "/home/John/aws-access-key.pub"
ssh_private_key_path = "/home/John/aws-access-key"
shared_credentials_file_path = "/home/John/aws_credentials"
shared_credentials_profile = "myawsprofile"
```

##### Additionally to make your life easier you can:

* In ansible make sure to disable host key checks otherwise you are gonna have a bad time
`/etc/ansible/ansible.cfg`
```
[defaults]
host_key_checking = False
```
Also add your aws key to the ssh-agent `ssh-add aws_access_key`

### Running the project

In order to run the project all you have to do is type:

`terraform init`

`terraform apply`

And that's it! It will deploy all the required infrastructure as well as run the Ansible playbook to configure the webserver and upload required files

The LB DNS Domain which you can run in your browser to verify the logic will be present to you as terraform output 

`/about.php` -- Should direct you to 1st instance all the time (You can check the Instance IP displayed on page

`/contact.php` -- Should direct you to 1st instance all the time (You can check the Instance IP displayed on page

`other paths` -- Should balance you between both instances

Enjoy! :) 

### Cleanup

In order to remove all infrastructure simply run:

`terraform destroy`

###### PS. The terraform modules organization can be made a little more reusable and clean however due to limited time and `christmas` I had to take a couple of shortcuts :()

In case of questions feel free to mail me! 