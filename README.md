# Brainstorm Technical Assignment

Brief project description and purpose.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
  - [Terraform Setup](#terraform-setup)
  - [Ansible Setup](#ansible-setup)
- [Deploying the Project](#deploying-the-project)
- [Excluded Files](#excluded-files)

## Prerequisites

Before you begin, ensure you have met the following requirements:

- [AWS Account](https://aws.amazon.com/)
- [AWS CLI]()
- [Terraform](https://www.terraform.io/) installed locally.
- [Ansible](https://www.ansible.com/) installed locally.
- SSH key pairs for AWS access.

## Getting Started

To get the project up and running locally, follow these steps:

### Terraform Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/your-repo.git
   cd your-repo
   cd terraform
   ```
2. Create a `terraform.tfvars` file with the variables listed in [`variables.tf`](./terraform/variables.tf)
3. Initialize Terraform to download provider plugins from HashiCorp's official registry:
    ```bash
    terraform init
    ```
4. Run `terraform plan`, then run `terraform apply`. Enter `yes` when prompted.

### Ansible Setup

1. CD into the [ansible](./ansible) folder. Ansible configures the server by installing NGINX, PHP, MySQL, and SSL.
2. Modify the `inventory.yaml` and `ansible.cfg` files to update the hosts IP, and the ssh-key file.
3. Run the ansible playbook command
    ```bash
    ansible-playbook -i inventory.yaml lemp-config.yaml
    ```

### Wordpress Deployment

There is a [Github action](./github/workflows/develop.yaml) that copies your updated wordpress files in [wordpress](./wordpress) whenever a change is made.

### Excluded files
Certain sensitive files have been excluded from this repository, including:

.pem files in the root folder and ansible folder. You should create your SSH key pairs and update the Terraform and Ansible configurations accordingly.