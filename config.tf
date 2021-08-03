terraform {
  required_version = ">= 0.12"
  required_providers {

    docker = {
      source  = "kreuzwerker/docker"
      version = "2.11.0"
    }
  }

}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}
resource "docker_image" "nginx" {
  name = "nginx:1.11-alpine"
}


resource "docker_container" "nginx-server" {
  name = "nginx-server"
  image = docker_image.nginx.latest
  ports {
    internal = 80
    external = "8080"
  }
  volumes {
    container_path  = "/usr/share/nginx/html"
    host_path = "/home/savaj/terraform/html"
    read_only = true
  }
}

