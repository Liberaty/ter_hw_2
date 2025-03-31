resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "develop" {
  name           = local.subnet_name_develop_a
  zone           = var.default_zone[0]
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr_a
}

resource "yandex_vpc_subnet" "develop-db" {
  name           = local.subnet_name_develop_b
  zone           = var.default_zone[1]
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr_b
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_image_name
}

resource "yandex_compute_instance" "vm-web" {
  name        = local.vm_web_name
  hostname    = local.vm_web_name
  platform_id = var.vms_config[0].platform_id
  zone        = var.default_zone[0]
  resources {
    cores         = var.vms_config[0].cores
    memory        = var.vms_config[0].memory
    core_fraction = var.vms_config[0].core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.vms_config[0].hdd_size
      type     = var.vms_config[0].hdd_type
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_public_root_key}"
  }

}

resource "yandex_compute_instance" "vm-db" {
  name        = local.vm_db_name
  hostname    = local.vm_db_name
  platform_id = var.vms_config[1].platform_id
  zone        = var.default_zone[1]
  resources {
    cores         = var.vms_config[1].cores
    memory        = var.vms_config[1].memory
    core_fraction = var.vms_config[1].core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.vms_config[1].hdd_size
      type     = var.vms_config[1].hdd_type
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop-db.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_public_root_key}"
  }

}