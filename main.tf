terraform {
  required_providers {
    lxd = {
      source = "terraform-lxd/lxd"
    }
  }
}

provider "lxd" {
}

resource "lxd_instance" "elk-node-01" {
  name      = "elk-node-01"
  image     = "ubuntu:20.04"
  type      = "virtual-machine"

  limits = {
  cpu = 2
  memory = "3GiB"
}
}

resource "lxd_instance_file" "node-01" {
  instance_name     = "${lxd_instance.elk-node-01.name}"
  target_file        = "/home/ubuntu/.ssh/authorized_keys"
  source             = "/home/n/.ssh/id_rsa.pub"
  create_directories = true
}

resource "lxd_instance" "elk-node-02" {
  name      = "elk-node-02"
  image     = "ubuntu:20.04"
  type      = "virtual-machine"

  limits = {
  cpu = 2
  memory = "3GiB"
}
}

resource "lxd_instance_file" "node-02" {
  instance_name     = "${lxd_instance.elk-node-02.name}"
  target_file        = "/home/ubuntu/.ssh/authorized_keys"
  source             = "/home/n/.ssh/id_rsa.pub"
  create_directories = true
}

resource "lxd_instance" "elk-node-03" {
  name      = "elk-node-03"
  image     = "ubuntu:20.04"
  type      = "virtual-machine"

  limits = {
  cpu = 2
  memory = "3GiB"
}
}

resource "lxd_instance_file" "node-03" {
  instance_name     = "${lxd_instance.elk-node-03.name}"
  target_file        = "/home/ubuntu/.ssh/authorized_keys"
  source             = "/home/n/.ssh/id_rsa.pub"
  create_directories = true
}

resource "lxd_instance" "elk-node-04" {
  name      = "elk-node-04"
  image     = "ubuntu:20.04"
  type      = "virtual-machine"

  limits = {
  cpu = 2
  memory = "3GiB"
}
}

resource "lxd_instance_file" "node-04" {
  instance_name     = "${lxd_instance.elk-node-04.name}"
  target_file        = "/home/ubuntu/.ssh/authorized_keys"
  source             = "/home/n/.ssh/id_rsa.pub"
  create_directories = true
}

resource "lxd_instance" "elk-node-05" {
  name      = "elk-node-05"
  image     = "ubuntu:20.04"
  type      = "virtual-machine"

  limits = {
  cpu = 2
  memory = "3GiB"
}
}

resource "lxd_instance_file" "node-05" {
  instance_name     = "${lxd_instance.elk-node-05.name}"
  target_file        = "/home/ubuntu/.ssh/authorized_keys"
  source             = "/home/n/.ssh/id_rsa.pub"
  create_directories = true
}

resource "lxd_instance" "elk-node-06" {
  name      = "elk-node-06"
  image     = "ubuntu:20.04"
  type      = "virtual-machine"

  limits = {
  cpu = 2
  memory = "3GiB"
}
}

resource "lxd_instance_file" "node-06" {
  instance_name     = "${lxd_instance.elk-node-06.name}"
  target_file        = "/home/ubuntu/.ssh/authorized_keys"
  source             = "/home/n/.ssh/id_rsa.pub"
  create_directories = true
}

resource "lxd_instance" "elk-node-07" {
  name      = "elk-node-07"
  image     = "ubuntu:20.04"
  type      = "virtual-machine"

  limits = {
  cpu = 2
  memory = "3GiB"
}
}

resource "lxd_instance_file" "node-07" {
  instance_name     = "${lxd_instance.elk-node-07.name}"
  target_file        = "/home/ubuntu/.ssh/authorized_keys"
  source             = "/home/n/.ssh/id_rsa.pub"
  create_directories = true
}

resource "lxd_instance" "elk-node-08" {
  name      = "elk-node-08"
  image     = "ubuntu:20.04"
  type      = "virtual-machine"

  limits = {
  cpu = 2
  memory = "3GiB"
}
}

resource "lxd_instance_file" "node-08" {
  instance_name     = "${lxd_instance.elk-node-08.name}"
  target_file        = "/home/ubuntu/.ssh/authorized_keys"
  source             = "/home/n/.ssh/id_rsa.pub"
  create_directories = true
}

resource "lxd_instance" "elk-node-09" {
  name      = "elk-node-09"
  image     = "ubuntu:20.04"
  type      = "virtual-machine"

  limits = {
  cpu = 2
  memory = "3GiB"
}
}

resource "lxd_instance_file" "node-09" {
  instance_name     = "${lxd_instance.elk-node-09.name}"
  target_file        = "/home/ubuntu/.ssh/authorized_keys"
  source             = "/home/n/.ssh/id_rsa.pub"
  create_directories = true
}

resource "lxd_instance" "elk-node-10" {
  name      = "elk-node-10"
  image     = "ubuntu:20.04"
  type      = "virtual-machine"

  limits = {
  cpu = 2
  memory = "3GiB"
}
}

resource "lxd_instance_file" "node-10" {
  instance_name     = "${lxd_instance.elk-node-10.name}"
  target_file        = "/home/ubuntu/.ssh/authorized_keys"
  source             = "/home/n/.ssh/id_rsa.pub"
  create_directories = true
}