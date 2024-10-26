# IRISI Club Demo
This repo for the `2024-10` presentation's demo,

## Slides
- `fstg-irisi-club-presentation-slides.pdf`

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

## Objectives
- Create a EC2 instance with a security group with ingress 22/TCP and 8080/TCP ports using Terraform.
- Create a playbook that does:
    - Install `openjdk-17`
    - Create UNIX user `irisi`
    - Create a directory for app `/opt/irisi`
    - Build the application locally or on server `app/mvnw clean package`
    - Copy jar to the server `app/target/irisi-0.0.1-SNAPSHOT.jar` to `/opt/irisi/app.jar`
    - Start the application as a systemd service 

## The Solution 
You can check the solution with step by step guide in the `completed` branch.

## Verifying the app 

```shell
$ curl -X GET <server-ip>:8080/
```
