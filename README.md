# terraform-aws-migratorydata

A Terraform module to deploy and run MigratoryData on Amazon Web Services (AWS).

## Configuration

- To download and install Terraform, follow the steps given [here](https://www.terraform.io/downloads.html).

```bash
# for MacOS use brew
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

- Login to AWS with the following command and follow the instructions on the screen to configure your AWS credentials:

```bash
aws configure
```

- Or export the required credentials in current shell,

```bash
export AWS_ACCESS_KEY_ID="AKIAIOSFODNN7EXAMPLE"
export AWS_SECRET_ACCESS_KEY="wJal/…/bPxRfiCYEXAMPLEKEY"
```

For other authentication methods, take a look at the [AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication) documentation.

- Clone github repository with terraform configuration files:

```sh
git clone https://github.com/migratorydata/terraform-aws-migratorydata.git
cd terraform-aws-migratorydata/deploy
```

- Update the configuration files from `configs` directory with your values. See the [Configuration](https://migratorydata.com/docs/server/configuration/) section for more details.

- Add any extensions to the `extensions` directory.

- When the EC2 machines are created, all the configs and extensions files are copied on each instance.

- Create `terraform.tfvars` file to configure the ec2 machines with the following vars

```bash

namespace = "migratorydata"
address_space = "10.0.0.0/16"

instance_type = "t2.large"
# the number of nodes to start the MigratoryData cluster.
num_instances = 3

# set the maximum number of instances of MigratoryData Nodes to scale the deployment when necessary
max_num_instances = 5

region = "us-east-1"
availability_zone = "us-east-1a"

ssh_keyname = "ssh public key registered into aws dashboard"
ssh_private_key = "path to private key to access the ec2 machines and install all the necessary files"

migratorydata_download_url = "https://migratorydata.com/releases/migratorydata-6.0.15/migratorydata-6.0.15-build20240209.x86_64.deb"
```
For terraform to install all the necessary files on the EC2 instances, you need to provide the private key to access the EC2 machines and the public key registered into the AWS dashboard.

You can generate a new SSH key pair using the ssh-keygen command on your local machine, and then import the public key to AWS. Here's how you can do it:

```bash
# Generate the SSH key pair
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

# The command will prompt you to enter a file in which to save the key.
# You can press enter to use the default location, or specify a path where you want your key pair to be saved.

# You'll then be asked to optionally enter a passphrase for added security.
```

This will create two files: one for the private key (default is `~/.ssh/id_rsa`), and one for the public key (default is `~/.ssh/id_rsa.pub`).

Next, you need to import the public key to AWS. You can do this in the AWS Management Console:

- Open the Amazon EC2 console at https://console.aws.amazon.com/ec2/.
- In the navigation pane, under `NETWORK & SECURITY`, choose `Key Pairs`.
- Choose Import Key Pair.
- In the Import Key Pair dialog box, choose Browse and select the public key file (.pub file).
- Choose Import.

Update terraform.tfvars file with the path to the private key and the name of the public key registered into the AWS dashboard.


#### Deploy the cluster

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

#### Check the deployment

You can access the MigratoryData cluster using the NLB DNS name. You can find it in the AWS dashboard or by running the following command under `migratorydata_cluster_address` output:

```bash
terraform output 
```

#### Scale

To scale the deployment, update the `num_instances` variable in the `terraform.tfvars` file and run the following commands:

```bash
terraform plan
terraform apply
```

#### Cleanup

To destroy the deployment run the following command:

```bash
terraform destroy
```
