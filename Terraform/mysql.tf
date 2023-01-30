resource "google_sql_database_instance" "sql-server" {
  name                = "sql-server"
  region              = "europe-west1"
  database_version    = "MYSQL_5_7"
  deletion_protection = false

  settings {
    tier = "db-f1-micro"

    ip_configuration {

      ipv4_enabled = "true"

      authorized_networks {
        value =	module.VM4.ephermal_ip
      }
    }
  }
}

resource "google_sql_database" "database-name" {
  name     = "petclinic"
  instance = google_sql_database_instance.sql-server.name
}

resource "google_sql_user" "user" {
  name     = "petclinic1"
  instance = google_sql_database_instance.sql-server.name
  host     = module.VM4.ephermal_ip
  password = var.db_password
}