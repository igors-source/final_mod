resource "local_file" "ansuble_yml" {

  content  = templatefile("${path.module}/hosts.tftpl", {
    workers = yandex_compute_instance.worker
    masters = yandex_compute_instance.master
  })
  filename = "../ansible/inventory/hosts.yml"
}