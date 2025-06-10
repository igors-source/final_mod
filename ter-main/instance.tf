data "yandex_compute_image" "debian" {
  image_id = "fd8lmohmg218tbr9r45m"
}
resource "yandex_compute_instance" "master" {
  count = 1
  name        = "master-${count.index+1}"
  platform_id = "standard-v3"
  zone        = "ru-central1-b"

  resources {
    core_fraction = var.vm_resources.nat_res.core_fraction
    cores         = var.vm_resources.nat_res.cores
    memory        = var.vm_resources.nat_res.memory
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.debian.image_id
      size     = var.vm_resources.nat_res.disk_size
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    index     = 1
    subnet_id = yandex_vpc_subnet.zone-b.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./metadata.yml")}"
    #ssh-keys = "artem:${var.ssh_public}"
    serial-port-enable = "1"
  }
}
resource "yandex_compute_instance" "worker" {
  count = 2
  name        = "worker-${count.index+1}"
  platform_id = "standard-v3"
  zone        = "ru-central1-b"

  resources {
    core_fraction = var.vm_resources.nat_res.core_fraction
    cores         = var.vm_resources.nat_res.cores
    memory        = var.vm_resources.nat_res.memory
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.debian.image_id
      size     = var.vm_resources.nat_res.disk_size
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    index     = 1
    subnet_id = yandex_vpc_subnet.zone-b.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./metadata.yml")}"
    #ssh-keys = "artem:${var.ssh_public}"
    serial-port-enable = "1"
  }
}