resource "yandex_vpc_network" "igors-net" {
  name = "igors-net"
}

resource "yandex_vpc_subnet" "zone-a" {
  name           = "zone-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.igors-net.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_vpc_subnet" "zone-b" {
  name           = "zone-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.igors-net.id
  v4_cidr_blocks = ["192.168.20.0/24"]
}

resource "yandex_vpc_subnet" "zone-d" {
  name           = "zone-c"
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.igors-net.id
  v4_cidr_blocks = ["192.168.30.0/24"]
}
