# Multi-instance OB cluster

## Requirements

| Name                                                                     | Version |
| ------------------------------------------------------------------------ | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 0.14 |
| <a name="requirement_ansible"></a> [ansible](#requirement_ansible)       | 1.0.4   |
| <a name="requirement_aws"></a> [aws](#requirement_aws)                   | ~> 3.28 |
| <a name="requirement_cloudinit"></a> [cloudinit](#requirement_cloudinit) | ~> 2.1  |
| <a name="requirement_random"></a> [random](#requirement_random)          | ~> 3.0  |

## Providers

| Name                                                         | Version |
| ------------------------------------------------------------ | ------- |
| <a name="provider_ansible"></a> [ansible](#provider_ansible) | 1.0.4   |
| <a name="provider_aws"></a> [aws](#provider_aws)             | 3.56.0  |

## Modules

| Name                                                              | Source               | Version |
| ----------------------------------------------------------------- | -------------------- | ------- |
| <a name="module_configsvr"></a> [configsvr](#module_configsvr)    | ./modules/ob         | n/a     |
| <a name="module_networking"></a> [networking](#module_networking) | ./modules/networking | n/a     |
| <a name="module_obsvr"></a> [obsvr](#module_obsvr)                | ./modules/ob         | n/a     |

## Resources

| Name                                                                                                           | Type        |
| -------------------------------------------------------------------------------------------------------------- | ----------- |
| [ansible_host.configsvr](https://registry.terraform.io/providers/nbering/ansible/1.0.4/docs/resources/host)    | resource    |
| [aws_instance.obsvrs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/instance) | data source |

## Inputs

| Name                                                               | Description                                             | Type     | Default       | Required |
| ------------------------------------------------------------------ | ------------------------------------------------------- | -------- | ------------- | :------: |
| <a name="input_namespace"></a> [namespace](#input_namespace)       | The project namespace to use for unique resource naming | `string` | `"obsingle"`  |    no    |
| <a name="input_num"></a> [num](#input_num)                         | number of ob instances in cluster                       | `number` | `3`           |    no    |
| <a name="input_region"></a> [region](#input_region)                | AWS region                                              | `string` | `"us-west-2"` |    no    |
| <a name="input_ssh_keypair"></a> [ssh_keypair](#input_ssh_keypair) | SSH keypair to use for EC2 instance                     | `string` | `"ansible"`   |    no    |

## Outputs

| Name                                                                    | Description |
| ----------------------------------------------------------------------- | ----------- |
| <a name="output_ob_public_ip"></a> [ob_public_ip](#output_ob_public_ip) | n/a         |
