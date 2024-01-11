
# Automating-AWS-Infrastructure-with-Terraform-for-Provisioning-Static-Web-App-Deployment

## Description
This covers how terraform is used to provision aws Infrastructure and use terraform provision to execute deployment on the resources.


## Prerequisites

- Install [Terraform](https://www.terraform.io/downloads.html) .
- AWS credentials configured with appropriate permissions.


## Usage
- Clone the repo.
```
git clone https://github.com/OK-CodeClinic/Automating-AWS-Infrastructure-with-Terraform-for-Provisioning-Static-Web-App-Deployment 

cd Automating-AWS-Infrastructure-with-Terraform-for-Provisioning-Static-Web-App-Deployment
```

- Initilize terraform
```
terraform Initilize
```
- Modify the variables in variables.tf to suit your requirements. For example, you can change the VPC CIDR block, subnet CIDR blocks, or specify a different EC2 instance type.

- Apply terraform configuration
```
terraform Apply
```



### What happens when terraform is applied in this scenario?
- Creates a VPC with specified CIDR block.
- Attaches an Internet Gateway to the VPC for internet access.
- Defines public subnets within the VPC.
- Creates a security group allowing incoming traffic on ports 80, 443, and 22.
- Launches an EC2 instance in the public subnet 
- Assigns a key pair (```terra-key```), and associates the security group.
- Deployment: Copies a local shell script (app.sh) to the EC2 instance and executes it using remote-exec.
- Output: After the deployment is complete, Terraform will output the public and private IP addresses of the EC2 instance


#### What does ```app.sh``` does?
- Installs three packages (wget, unzip, and httpd) using the yum package manager.
- Starts and enable  the Apache HTTP server (httpd) using ```systemctl start httpd``` and ```systemctl enable httpd```.
- Downloads a ZIP file (2117_infinite_loop.zip) from the specified URL (https://www.tooplate.com/zip-templates/2117_infinite_loop.zip) using ```wget```.
- Unzips the downloaded ZIP file using ```unzip -o 2117_infinite_loop.zip```.
- Copies the contents of the unzipped directory (2117_infinite_loop/) to the Apache web server's document root (/var/www/html/)  ```cp -r 2117_infinite_loop/* /var/www/html/```.
- Restarts the Apache HTTP server using ```systemctl restart httpd```


### Cleanup
To destroy the created resources after testing.
``` 
terraform destroy 
```.

## Summary
This project goes beyond demonstrating Terraform's infrastructure provisioning capabilities; it emphasizes the utilization of Terraform for deployment provisioning. In complex deployment scenarios, leveraging configuration management tools such as Ansible, Puppet, and Chef is recommended for enhanced control and efficiency.









