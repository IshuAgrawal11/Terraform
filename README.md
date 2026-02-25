# 🚀 AWS EC2 Infrastructure Automation with Terraform
[![Terraform](https://img.shields.io/badge/Terraform-v1.0+-623CE4?style=for-the-badge\&logo=terraform)](https://developer.hashicorp.com/terraform)
[![AWS](https://img.shields.io/badge/AWS-EC2-orange?style=for-the-badge\&logo=amazon-aws)](https://aws.amazon.com/ec2/)
[![Nginx](https://img.shields.io/badge/Nginx-Web%20Server-009639?style=for-the-badge\&logo=nginx)](https://nginx.org/)
[![Infrastructure as Code](https://img.shields.io/badge/IaC-Terraform-blue?style=for-the-badge)]()
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)]()

Production-ready Infrastructure as Code (IaC) project that provisions an AWS EC2 instance and automatically installs and configures Nginx using Terraform.

This project demonstrates clean architecture, modular Terraform design, and automated provisioning suitable for DevOps portfolios and real-world deployments.

---

## 📌 Overview

This repository automates the deployment of an Ubuntu-based EC2 instance on AWS. During provisioning, a bootstrap script installs and configures an Nginx web server automatically — enabling zero-touch infrastructure setup.

The configuration is modular, customizable, and suitable for learning, demonstrations, or lightweight production workloads.

---

## ✨ Key Features

* **Infrastructure as Code (IaC)** using Terraform
* **Automated EC2 provisioning** in a configurable AWS region
* **Zero-touch Nginx installation** via `user_data`
* **Fully parameterized configuration** using input variables
* **Automated output exposure** (IPs and DNS)
* **Clean and modular file structure**

---

## 🏗️ Architecture

Terraform provisions:

* AWS Provider configuration
* Ubuntu-based EC2 instance
* User data script execution (`nginx.sh`)
* Output values for connectivity

On instance launch:

1. EC2 boots
2. `user_data` executes
3. Nginx installs and starts automatically
4. Public IP becomes accessible via browser

---

## 📁 Project Structure

```
.
├── ec2.tf            # EC2 resource definition & user_data integration
├── nginx.sh          # Shell script for automated Nginx installation
├── output.tf         # Output values (IPs and DNS)
├── provider.tf       # AWS provider configuration
├── terraform.tf      # Terraform version & backend requirements
└── variable.tf       # Input variables for modular configuration
```

---

## ⚙️ Prerequisites

Ensure the following are installed and configured:

* **Terraform** (v1.0 or later)
  👉 [https://developer.hashicorp.com/terraform/downloads](https://developer.hashicorp.com/terraform/downloads)

* **AWS CLI configured**

  ```bash
  aws configure
  ```

* **Existing AWS EC2 Key Pair**
  The key name must match the value specified in `variable.tf` or `terraform.tfvars`.

* IAM user with sufficient permissions to create:

  * EC2 instances
  * Security groups
  * VPC-related resources (if applicable)

---

## 🚀 Getting Started

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/IshuAgrawal11/Terraform.git
cd Terraform
```

---

### 2️⃣ Initialize Terraform

Downloads required providers and initializes backend:

```bash
terraform init
```

---

### 3️⃣ Configure Variables

You can modify default values in `variable.tf` or create a `terraform.tfvars` file:

```hcl
region        = "eu-north-1"
instance_type = "t3.micro"
key_name      = "your-key-name"
```

Recommended approach: use `terraform.tfvars` (keeps core files unchanged).

---

### 4️⃣ Validate Configuration (Optional but Recommended)

```bash
terraform validate
terraform fmt
```

---

### 5️⃣ Review Execution Plan

```bash
terraform plan
```

This shows resources Terraform will create before applying changes.

---

### 6️⃣ Deploy Infrastructure

```bash
terraform apply -auto-approve
```

After completion, Terraform will output connectivity details.

---

## 🌐 Accessing Nginx

Once deployed:

1. Copy the `public_ip` from Terraform output.
2. Open in your browser:

```
http://<public_ip>
```

You should see the default Nginx welcome page.

---

## 📊 Outputs

| Output Name   | Description                         |
| ------------- | ----------------------------------- |
| `public_ip`   | Public IPv4 address of EC2 instance |
| `private_ip`  | Internal VPC IP address             |
| `public_dns`  | Public DNS hostname                 |
| `private_dns` | Internal AWS DNS hostname           |

---

## 🧹 Destroy Infrastructure

To prevent unnecessary AWS charges:

```bash
terraform destroy -auto-approve
```

---

## 🔐 Security Notes

* Avoid committing AWS credentials.
* Use IAM roles instead of static credentials in production.
* Restrict security group rules (avoid `0.0.0.0/0` for SSH in real environments).
* Consider remote backend (S3 + DynamoDB) for team environments.

---

## 📦 Future Improvements

* Add Security Group resource definition
* Use Remote Backend (S3 + DynamoDB locking)
* Convert into reusable Terraform module
* Add CI/CD pipeline (GitHub Actions)
* Add Auto Scaling support

---

## 📜 License

This project is for educational and demonstration purposes.
You may modify and use it according to your needs.

---

