## Deploying an NGINX Server in AWS

- In this project, we will be deploying an NGINX server in AWS. We will create a new VPC, set up public and private subnets, and deploy an EC2 instance using the Ubuntu AMI. Later, we will replace the instance with an NGINX Bitnami AMI and associate it with a security group. Finally, we will test the website accessibility and tag the resources with project information. Make sure to use Terraform for as many resources as possible, and remember to delete all the resources at the end of the project to avoid unnecessary costs.
<br>

**Project Overview**

![How IaC works](../snippets/proj-nginx.png)

## Steps for Implementation
1. Deploy a VPC and a subnet. [DONE]
2. Deploy an Internet Gateway (IGW), and associate it with VPC. [DONE]
3. Setup Route Table with routes to IGW and associate it with subnet. [DONE]
4. Deploy EC2 instance inside subnet and Associate a public IP [DONE]
5. Associate a security group that allows public ingress. [DONE]
6. Change the EC2 instance to use a publicly available NGINX AMI. [DONE]


Link :
AMI : https://cloud-images.ubuntu.com/locator/ec2/
