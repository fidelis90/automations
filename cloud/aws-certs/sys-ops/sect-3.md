# EC2 for SysOps 

- you can change the instance type of an instance, stop the instance, change the instance type and start the instance 

## Enhanced Networking 

A way to get better networking for your ec2 instances 

1. SR-IOV: Higher bandwidth, Higher PPS(Packet per second), lower latency, works for newer generation
  - Option 1: Elastic Network Adapter up to 100Gbps 
  - Option 2: Intel 82599 VF up to 10Gbps - Legacy 

2. Elastic Fabric Adapter (EFA): improved ENA for HPC, only works for linux, great inter node communication, bypass underlying linux OS to provide low-latency, reliable transport 

```
modinfo ena ( this commands gives ena info )
ethtool -i eth0 ( tells the network driver used)
```

## Placement groups

controls how aws places our instances in their infrastructure 
when you create a placement group, you specify:
* cluster: same rack same AZ, good network but not good for high availability
* spread: on different hardware,max 7 instances per group per AZ 
* Partition: up to 7 partitions per AZ, can have upto 100s of ec2 instances, partition info in metadata 

## Shutdown behavior of ec2 instances 

even enable termination protection is enabled, if we shutdown the instance from OS level the instance will be terminated 

## Limits 

we can check limits for services in Service Quotas, the limits of vCpus for on demand and spot instances is 64 vcpus limit, we can request increase

## Ec2 Instances purchasing options 

On-demand: short workload, predictable pricing, pay by second, highest cost but no upfront payment
reserved: long workloads, 72% discount compared to on demand 
savings plans: long workloads, commiting to certain type of usage($10/hour for 1 or 3 years) 
spot instances: cheap but less reliable, for batch jobs, data analysis not suitable for dbs
dedicated host: book an entire physical server, control instance placement, most expensive
dedicated instances: uses dedicated physical server too, may share hardware with other instances in same account, no control over in stance placement
capacity reservations: reserve capacity in a specific az for any duration 

Non technical explanation of purchasing options 

On demand: as i need it i pay for it whenever i like at full price 
reserved: planning ahead, and if we stay a long time we get a discount 
savings plans: pay per hour for a certain amount of time in a room type

### Ec2 spot instance requests

define a max-spot-price and get the ec2 instance when current spot price < max spot price
spot price varies hourly 
if the current spot price > your max spot price, stop or terminate the instance with a 2 mins grace period
you can also use spot block, blocks a instance for a time frame, but can be reclaimed
you can only cancel spot instance requests that are open, active or disabled. canceling a spot requests doesn't terminate the instances, you still need to terminate the associated spot instances

### Burstable Instances

these instances are available for T2/T3 instances 
burst means OK CPU performance 
machine burst == utilize burst credits
machine stops bursting == accumulates credit over time

### Elastic IPs

This is a Fixed public IP 
you can attach it to one instance at a time 
you don't pay for the elastic IP if it's atached to a server, you pay when it's not attached 
by default, you can have up to 5 elastic ips in your account 

### Cloudwatch metrics for ec2 

AWS Provided Metrics 
  -  basic monitoring(default): metrics are collected every 5 mins 
  -  detailed monitoring(paid): every 1 min 
  -  Includes CPU, Network, Disk and Status Check metrics 

Custom Metrics(yours to push)
  - Include RAM, application level metrics 
  - IAM roles on ec2 instances must give permissions to cloudwatch 

EC2 Included Metrics 
  - CPU
  - Network 
  - Status Check
    - instance status
    - system status 
  - Disk

RAM usage is a custom metrics 

### Unified CW Agent 

Runs in ec2 instances or on-prem servers 
Collects additional system-level metrics such as RAM, processes, used disk space etc
collects logs to send to cloudwatch logs 
centralized config using SSM param store 
default namespace for cw agent = cwagent
cwagent has a procstat plugin that collects metrics and monitor system utilization of individual processes
metrics collected by proctstat plugin begins with proctsat_

### EC2 Instance Status Checks 

Status checks are automated checks to identify hardware and software issues 
when you stop and start an ec2 instance, the instance is migrated to a different host  
StatusCheckFailed_System
StatusCheckFailed_Instance

System Checks
- monitor the aws systems on which your instance runs 
- Problem with underlying hosts 
  - loss of network connectivity 
  - loss of system power 
  - software issues on the physical host
  - hardware issues on the physical host that impact network reachability
- Solutions
  - Either wait for AWS to fix the host, OR 
  - Move the instance to a new host = stop & start the instance(if EBS backed)

### EC2 Hibernate

stop: the data on the disk is intact 
terminate: any EBS volume(root) also set-up to be destroyed is lost 
hibernate: 
  - in memory RAM state is preserved making OS much faster
  - under the hood, the RAM state is written to a file in the root EBS volume 
  - the root EBS vol must be encrypted
  - the OS is not stopped/restarted 
  - hibernate not more than 60 days 