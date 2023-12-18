# platform

## required
 - [awscli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
 - [terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### configure AWS Credentials

Open the file `~/.aws/credentials` and the AWS Account configuration:

```shell
[omnes-gentes]
aws_access_key_id = [access-key]
aws_secret_access_key = [secret-key]
```

## Deploy the Infrastructure

Setup terraform:
```shell
terraform init
```

Review the infrastructure:
```shell
terraform plan
```

Deploy the infrastructure:
```shell
terraform apply --auto-approve
```