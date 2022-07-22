# This will be used for the node group creation. the template for creating the ec2 instances in each node groups 

resource "aws_launch_template" "eks-workers" {
  name                   = "${var.cluster_name}-lt"
  description            = "Launch template for node groups"
  update_default_version = true

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = var.ebs_volume
    }
  }

  #   cpu_options {
  #     core_count       = 4
  #     threads_per_core = 2
  #   }

  instance_type = var.instance_type

  key_name = var.keypair

  monitoring {
    enabled = var.enable_monitoring
  }

  /* network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    security_groups             = [module.eks.cluster_security_group_id, aws_security_group.all_worker_mgmt.id]
  } */

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.cluster_name}-worker"
    }
  }

  #   user_data = filebase64("${path.module}/example.sh")
}
