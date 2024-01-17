# terraform-aws-migratorydata

A Terraform module to deploy and run MigratoryData on Amazon Web Services (AWS).

## Configuration

- To download and install Terraform, follow the steps given [here](https://www.terraform.io/downloads.html).

- Export the required credentials in current shell,

  ```sh
  export AWS_ACCESS_KEY_ID="AKIAIOSFODNN7EXAMPLE"
  export AWS_SECRET_ACCESS_KEY="wJal/…/bPxRfiCYEXAMPLEKEY"
  ```

  For other authentication methods, take a look at the [AWS
  Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication)
  documentation.

- Clone this repo and go to `deploy` directory to run a MigratoryData cluster,

  ```sh
  $ git clone https://this_repo
  $ cd this_repo
  ```

- Depending on the features used from MigratoryData server update all the configuration files found in directory `configs`.

- Add any extension if necessary to directory `extensions`. 

- When the EC2 machines are prepared all the configs files and extensions are copied on each one.

- Create `terraform.tfvars` file to configure the ec2 machines with the following vars

```bash
cluster_name = "universe"
migratorydata_prefix = "migratorydata"
cidr_block = "10.0.2.0/24"

# the number of nodes to start the MigratoryData cluster.
num_instances = 3

# set the maximum number of instances of MigratoryData Nodes to scale the deployment when necessary
max_num_instances = 5

ssh_keyname = "ssh public key registered into aws dashboard"
ssh_private_key = "path to private key to access the ec2 machines and install all the necessary files"
```


## Usage

Initialize Terraform first if you have not already done so.

```
$ terraform init
```

To check what changes are going to happen in the environment run the following,

```
$ terraform plan
```

Now run the following to create the instances and bring up the cluster.

```
$ terraform apply
```

Once the cluster is created, you can go to the URL `http://<node ip or dns name>:8800` to view the MigratoryData Debug UI. You can find the node's IP address or DNS by running the following:

```
$ terraform state show module.migratorydata-db-cluster.aws_instance.migratorydata_nodes[0]
```

You can access the MigratoryData Debug UI by going to public IP address of any of the instances at port `8800`. The IP address can be viewed by replacing `0` from above command with desired index.

You can check the state of the nodes at any point by running the following command.

```
$ terraform show
```

To destroy what we just created, you can run the following command.

```
$ terraform destroy
```

`Note:- To make any changes in the created cluster you will need the terraform state files. So don't delete state files of Terraform.`
