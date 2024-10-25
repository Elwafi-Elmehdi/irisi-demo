# IRISI Club Demo
This repo for the `2024-10` presentation's demo

## Credentials
- Create or Identify an IAM User:
    - Sign in to the AWS Management Console.
    - Go to the IAM service and navigate to Users.
    - Create a new user with Programmatic access, or use an existing user.

- Attach a Policy to the IAM User:
    - During user creation, attach policies like AdministratorAccess or AmazonEC2FullAccess.

- Generate AWS Access Keys:
    - After creating the user, download the .csv file with the Access Key ID and Secret Access Key, or copy the credentials.
    - For existing users, go to Security credentials → Access keys → Create access key.


Now go to the credentials file and edit it.
```shell
$ vim ~/.aws/credentials
```
Past your access and secret keys under a profile called `personnel-aws`
```ini
[personnel-aws]
aws_access_key_id = <access key>
aws_secret_access_key = <scret key>
```

## The Solution 
The following two sections describe the step by step how we are meeting the demo objectives. 
### Objective #1 : Deploying the infrastructure

```shell
$ ssh-keygen -t rsa -b 4096 -C "irisi club demo keys"
```

```hcl
variable "ssh_public_key_path" {
  default = "~/.ssh/irisi.pub"
  description = "The SSH public key path"
}
```

```shell
$ cd terraform
```

```shell
$ terraform plan
```

```shell
$ terraform apply
```

you should see the plan summary like this: 
```shell
Plan: 3 to add, 0 to change, 0 to destroy.
```
### Objective #2 : Configuring the environment and deploying the app


```shell
$ cd ansible
```

```shell
$ ansible-playbook -u ubuntu --private-key=~/.ssh/irisi  -i inventory/hosts.ini --limit webservers playbooks/setup-app-playbook.yml --diff 
```

## Verifying the app 
