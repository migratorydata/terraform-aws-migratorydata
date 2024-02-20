## terraform-aws-migratorydata

A Terraform module to deploy and run MigratoryData on Amazon Web Services (AWS).

## Prerequisites

Ensure that you have an AWS account and have installed the following tools:

  - [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
  - [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

## Login to AWS

Login to AWS with the following command and follow the instructions on the screen to configure your AWS credentials:

```bash
aws configure
```

Or export the required credentials in current shell,

```bash
export AWS_ACCESS_KEY_ID="AKIAIOSFODNN7EXAMPLE"
export AWS_SECRET_ACCESS_KEY="wJal/…/bPxRfiCYEXAMPLEKEY"
```

For other authentication methods, take a look at the [AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication) documentation.

## Configure the deployment

Clone the MigratoryData's repository with terraform configuration files:

```bash
git clone https://github.com/migratorydata/terraform-aws-migratorydata
cd terraform-aws-migratorydata/deploy
```

Update if necessary the configuration files from the `deploy/configs` directory. See the [Configuration](https://migratorydata.com/docs/server/configuration/) guide for more details. If you developed custom extensions, add them to the the `deploy/extensions` directory.

When the EC2 machines are created, all the configs and extensions files are copied on each instance.

Update `terraform.tfvars` file to match your configuration. The following variables are required:

  - `region` - The AWS region where the resources will be deployed.
  - `availability_zone` - The availability zone where the resources will be deployed.
  - `namespace` - The namespace for the resources.
  - `address_space` - The address space for the virtual network.
  - `num_instances` - The number of nodes to start the MigratoryData cluster.
  - `max_num_instances` - The maximum number of instances of MigratoryData Nodes to scale the deployment when necessary.
  - `instance_type` - The type of the virtual machines to be deployed.
  - `ssh_private_key` - The path to the private key used to access the virtual machines.
  - `migratorydata_download_url` - The download URL for the MigratoryData package.

```bash

region = "us-east-1"
availability_zone = "us-east-1a"

namespace = "migratorydata"
address_space = "10.0.0.0/16"

num_instances = 3
max_num_instances = 5

instance_type = "t2.large"
ssh_private_key = "~/.ssh/id_rsa"

migratorydata_download_url = "https://migratorydata.com/releases/migratorydata-6.0.15/migratorydata-6.0.15-build20240209.x86_64.deb"
```

## SSH keys

For terraform to install all the necessary files on the EC2 instances, you need to provide the private key to access the EC2 machines.

You can generate a new SSH key pair using the `ssh-keygen` command on your local machine, and then set the path to private key to the terraform deployment using var `ssh_private_key`. Here's how you can do it:

```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

This will generate in the `.ssh` directory a public key, i.e. `~/.ssh/id_rsa.pub`, and a private key, i.e. `~/.ssh/id_rsa`. 

Update `terraform.tfvars` file with the path to the private key.


## Deploy MigratoryData

Initialize terraform:
```bash
terraform init
```

Check the deployment plan:
```bash
terraform plan
```

Apply the deployment plan:
```bash
terraform apply
```

## Verify deployment

You can access the MigratoryData cluster using the NLB DNS name. You can find it in the AWS dashboard. You can also find it under `migratorydata_cluster_address` in the output of the following: 

```bash
terraform output 
```

Also you can ssh into the virtual machines using the public ip of the virtual machines. You can find it under `cluster-nodes-public-ips` output and ssh into the virtual machines using the following command:

```bash
ssh admin@machine_public_ip
or
ssh -i ssh_private_key admin@machine_public_ip
```

## Scale

To scale the deployment, update the `num_instances` variable in the `terraform.tfvars` file and run the following commands:

```bash
terraform plan
terraform apply
```

## Uninstall

To destroy the deployment run the following command:

```bash
terraform destroy
```

## Build realtime apps

Use any of the MigratoryData's [client APIs](/docs/client-api/) to develop real-time applications for communication with this MigratoryData cluster.
