# PROJECT-17
AUTOMATE INFRASTRUCTURE WITH IAC USING TERRAFORM PART 2

- Before we go deeper into automating other parts of our infrastructure on AWS, it is very important to fully understand certain concepts around **Networking** (in case this is completely new area to you). Networking is a very broad topic and some of internals of Terraform modules related to Networking, like ***cidrsubnet()***, may still not be fully clear to you.

- To fully clear your understanding, we highly recommend you watching Networking videos by Eli the Computer Guy on YouTube, and in addition to that, read following golden articles on **Networking Terminology, Interfaces, Protocols, IP Address, Subnets, and CIDR Notation by Justin Ellingwood from Digital Ocean**.

**Eli the Computer Guy videos**

  - [Introduction to Networking](https://www.youtube.com/watch?v=rL8RSFQG8do)

  - [TCP/IP and Subnet Masking](https://www.youtube.com/watch?v=EkNq4TrHP_U)

- If you are interested to dive deeper into Networking domain, you can watch the entire playlist [here](https://www.youtube.com/playlist?list=PLF360ED1082F6F2A5)

  - [Networking Part 1](https://www.digitalocean.com/community/tutorials/an-introduction-to-networking-terminology-interfaces-and-protocols)
 
  - [Networking Part 1](https://www.digitalocean.com/community/tutorials/understanding-ip-addresses-subnets-and-cidr-notation-for-networking#netmasks-and-subnets)

**IP Address**

  - An IP address is a unique address that identifies a device on the internet or a local network. IP stands for "Internet Protocol," which is the set of rules governing the format of data sent via the internet or local network.

**Subnets**

  - A subnet, or subnetwork, is a segmented piece of a larger network. More specifically, subnets are a logical partition of an IP network into multiple, smaller network segments.
    
**CIDR Notation**

  - CIDR notation (Classless Inter-Domain Routing) is an alternate method of representing a subnet mask. It is simply a count of the number of network bits (bits that are set to 1) in the subnet mask.

**IP Routing**

  - IP routing is the process of sending packets from a host on one network to another host on a different remote network

**Internet Gateways**

  - An internet gateway is a horizontally scaled, redundant, and highly available VPC component that allows communication between your VPC and the internet

**NAT**

  - A NAT gateway is a Network Address Translation (NAT) service. You can use a NAT gateway so that instances in a private subnet can connect to services outside your VPC but external services cannot initiate a connection with those instances.

**Networking**

***Private subnets & best practices***


- Create 4 private subnets keeping in mind following principles:

    - Make sure you use variables or ***length()*** function to determine the number of AZs
      
    - Use variables and ***cidrsubnet()*** function to allocate ***vpc_cidr*** for subnets

    - Keep variables and resources in separate files for better code structure and readability

    - Tags all the resources you have created so far. Explore how to use ***format()*** and ***count*** functions to automatically tag subnets with its respective number.

<img width="957" alt="Creating 4 Private subnets and tagging" src="https://github.com/eyolegoo/PROJECT-17/assets/115954100/774b4607-9041-46e6-95da-f13728917856">

<img width="820" alt="Creating 4 Private subnets ii" src="https://github.com/eyolegoo/PROJECT-17/assets/115954100/babf96bb-ac1c-4264-acb2-8a361305c33e">

<img width="733" alt="Creating 4 Private subnets iii" src="https://github.com/eyolegoo/PROJECT-17/assets/115954100/2ebb879b-76c9-4116-950c-231fea3de499">


**Internet Gateways & ***format()*** function**

- Create an Internet Gateway in a separate Terraform file ***internet_gateway.tf***

<img width="958" alt="Internet-gw" src="https://github.com/eyolegoo/PROJECT-17/assets/115954100/f613f030-ae92-4943-9720-760ef77b7b5c">


**NAT Gateways**

- Create 1 NAT Gateways and 1 Elastic IP (EIP) addresses

- Now use similar approach to create the NAT Gateways in a new file called ***natgateway.tf**.

- Note: We need to create an Elastic IP for the NAT Gateway, and you can see the use of ***depends_on*** to indicate that the Internet Gateway resource must be available before this should be created. Although Terraform does a good job to manage dependencies, but in some cases, it is good to be explicit.

You can read more on dependencies [here](https://developer.hashicorp.com/terraform/language/meta-arguments/depends_on)


**AWS ROUTES**

- Create a file called **route_tables.tf** and use it to create routes for both public and private subnets, create the below resources.

- Ensure they are properly tagged.

  - aws_route_table
    
  - aws_route
    
  - aws_route_table_association
 
<img width="955" alt="route-table" src="https://github.com/eyolegoo/PROJECT-17/assets/115954100/233cd17a-b115-42f0-8ecd-fe44059d9567">

- Now, we are done with Networking part of AWS set up, let us move on to Compute and Access Control configuration automation using Terraform!


**AWS Identity and Access Management**

- [IaM](https://docs.aws.amazon.com/iam/) and [Roles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html)
  
- We want to pass an IAM role our EC2 instances to give them access to some specific resources, so we need to do the following:

1. - Create [AssumeRole](https://docs.aws.amazon.com/STS/latest/APIReference/API_AssumeRole.html)

- Assume Role uses Security Token Service (STS) API that returns a set of temporary security credentials that you can use to access AWS resources that you might not normally have access to. These temporary credentials consist of an access key ID, a secret access key, and a security token. Typically, you use ***AssumeRole*** within your account or for cross-account access.

Add the following code to a new file named ***roles.tf***

2. - Create [IAM policy](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_create.html) for this role
  
- This is where we need to define a required policy (i.e., permissions) according to our requirements. For example, allowing an IAM role to perform action **describe** applied to EC2 instances:

3. - Attach the ***Policy*** to the ***IAM Role***
  
- This is where, we will be attaching the policy which we created above, to the role we created in the first step.

4. - Create an [Instance Profile](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2_instance-profiles.html) and interpolate the ***IAM Role***

<img width="960" alt="roles" src="https://github.com/eyolegoo/PROJECT-17/assets/115954100/74ac21b5-7835-487a-ad0f-c60e3f8677bb">
  
- We are pretty much done with Identity and Management part for now, let us move on and create other resources required.


**Resources to be created**

- As per our architecture we need to do the following:

 1. - Create Security Groups
  
 2. - Create Target Group for Nginx, WordPress and Tooling
      
 3. - Create certificate from AWS certificate manager

 4. - Create an External Application Load Balancer and Internal Application Load Balancer.

 5. - create launch template for Bastion, Tooling, Nginx and WordPress

 6. - Create an Auto Scaling Group (ASG) for Bastion, Tooling, Nginx and WordPress

 7. - Create Elastic Filesystem

 8. - Create Relational Database (RDS)


**CREATE SECURITY GROUPS**

- We are going to create all the security groups in a single file, then we are going to refrence this security group within each resources that needs it.

***IMPORTANT***:

  - Check out the terraform documentation for [security group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)

  - Check out the terraform documentation for [security group rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule)

- Create a file and name it ***security.tf***, copy and paste the code below

<img width="960" alt="Sec grp 1" src="https://github.com/eyolegoo/PROJECT-17/assets/115954100/900dde5e-eec4-4445-af4d-f72f19f85b95">

<img width="960" alt="Sec grp 2" src="https://github.com/eyolegoo/PROJECT-17/assets/115954100/645dd1c5-41b3-4840-8f24-20d0597d6600">

<img width="738" alt="Sec grp 3" src="https://github.com/eyolegoo/PROJECT-17/assets/115954100/88f2b399-4c75-453a-8ffd-e1f5229772ab">

- ***IMPORTANT NOTE***: We used the ***aws_security_group_rule*** to refrence another security group in a security group.


**CREATE CERTIFICATE FROM AMAZON CERIFICATE MANAGER**

- Create ***cert.tf*** file and add the following code snippets to it.

- ***NOTE***: Read Through to change the domain name to your own domain name and every other name that needs to be changed.

  - Check out the terraform documentation for [AWS Certifivate manager](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate)
 
**Create an external (Internet facing) [Application Load Balancer (ALB)](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/application-load-balancer-getting-started.html)**

- Create a file ***called alb.tf***

First of all we will create the ALB, then we create the target group and lastly we will create the lsitener rule.

Useful Terraform Documentation, go through this documentation and understand the arguement needed for each resources:

  - [ALB](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb)
    
  - [ALB-target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group)
    
  - [ALB-listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener)
    
- We need to create an ALB to balance the traffic between the Instances:

- To inform our ALB to where route the traffic we need to create a [Target Group](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-target-groups.html) to point to its targets:

- Then we will need to create a [Listner](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-listeners.html) for this target Group

**Create an Internal (Internal) [Application Load Balancer (ALB)](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-internal-load-balancers.html)**
  
- For the Internal Load balancer we will fillow the same concepts with the external load balancer.

- Add the code snippets inside the ***alb.tf*** file

**To inform our ALB to where route the traffic we need to create a [Target Group](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-target-groups.html) to point to its targets**:

**Then we will need to create a [Listner](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-listeners.html) for this target Group**

<img width="960" alt="Creating Alb" src="https://github.com/eyolegoo/PROJECT-17/assets/115954100/bdb4795c-4b2e-4b7a-bd39-912cf9325bfc">

**Add the following outputs to ***output.tf*** to print them on screen**

<img width="747" alt="output" src="https://github.com/eyolegoo/PROJECT-17/assets/115954100/b206b416-414f-4121-b538-9b491667f1a0">


**CREATING AUSTOALING GROUPS**
