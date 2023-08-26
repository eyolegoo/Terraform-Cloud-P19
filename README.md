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

**IP Address:**

  - An IP address is a unique address that identifies a device on the internet or a local network. IP stands for "Internet Protocol," which is the set of rules governing the format of data sent via the internet or local network.

Subnets
A subnet, or subnetwork, is a segmented piece of a larger network. More specifically, subnets are a logical partition of an IP network into multiple, smaller network segments.
CIDR Notation
CIDR notation (Classless Inter-Domain Routing) is an alternate method of representing a subnet mask. It is simply a count of the number of network bits (bits that are set to 1) in the subnet mask.
IP Routing
IP routing is the process of sending packets from a host on one network to another host on a different remote network
Internet Gateways
An internet gateway is a horizontally scaled, redundant, and highly available VPC component that allows communication between your VPC and the internet
NAT
A NAT gateway is a Network Address Translation (NAT) service. You can use a NAT gateway so that instances in a private subnet can connect to services outside your VPC but external services cannot initiate a connection with those instances.
