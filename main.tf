module "environments" {
  source = "environments"
  shared_credentials_file_path = "${var.shared_credentials_file_path}"
  shared_credentials_profile = "${var.shared_credentials_profile}"
  ssh_private_key_path = "${var.ssh_private_key_path}"
  ssh_public_key_path = "${var.ssh_public_key_path}"
}