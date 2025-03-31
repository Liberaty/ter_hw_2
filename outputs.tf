output "info_of_vm" {
    value = [
        {vm_web = ["${yandex_compute_instance.platform.name}", "ssh -o 'StrictHostKeyChecking=no' ubuntu@${yandex_compute_instance.platform.network_interface[0].nat_ip_address}", "${yandex_compute_instance.platform.fqdn}"]},
        {vm_db  = ["${yandex_compute_instance.vm-db.name}", "ssh -o 'StrictHostKeyChecking=no' ubuntu@${yandex_compute_instance.vm-db.network_interface[0].nat_ip_address}", "${yandex_compute_instance.vm-db.fqdn}"]}
    ]
}