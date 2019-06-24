# DOA Infrastructure as a Code & Configuration Management

**Steps**
* Fork this repo
* Clone the forked repo and work in there
* Do not upload terraform.tfvars to public repo, keep updates in your workstation
* Remove terraform from cache `git rm --cached terraform.tfvars`

**Execute Terraform**
* terraform init (initializes terraform to use aws resources)
* terraform plan (checks the terraform template and show resources to be created)
* terraform apply (executes terraform plan)

**Next Steps**
* Modify ansible playbook to provision instance