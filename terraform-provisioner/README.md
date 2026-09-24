# Terraform Provisioner Demo

Provisions an AWS EC2 instance and demonstrates three provisioner types:

- **file** – copies `scripts/setup.sh` to the instance
- **remote-exec** – runs the script on the instance over SSH
- **local-exec** – logs to `provisioned_hosts.txt` on your machine, on both create and destroy

## Usage

```bash
terraform init
terraform plan -var="ami_id=ami-xxxxxxxx"
terraform apply -var="ami_id=ami-xxxxxxxx"
```

Provide your own AMI ID (region-specific) and SSH key paths, either via
`-var` flags, a `terraform.tfvars` file, or environment variables.

## Push to Git

```bash
cd terraform-provisioner-demo
git init
git add .
git commit -m "Add Terraform provisioner example"
git branch -M main
git remote add origin <YOUR_REPO_URL>
git push -u origin main
```

Note: `.gitignore` already excludes state files, `.tfvars`, and the
provider cache so secrets/state don't get committed.
