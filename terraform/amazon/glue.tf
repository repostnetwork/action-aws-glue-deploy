locals {
  glue_script_key = "admin/${var.glue_job_name}.py"
}

# TODO: Upload sample file for crawler to generate schema
resource "aws_s3_bucket_object" "glue_script" {
  bucket = var.glue_script_bucket
  key    = local.glue_script_key
  source = "/github/workspace/${var.glue_script_local_path}"
  etag   = filemd5("/github/workspace/${var.glue_script_local_path}")
}

resource "aws_glue_job" "glue_job_with_connection" {
  count    = tobool(var.connection_required) ? 1 : 0
  name     = var.glue_job_name
  role_arn = var.glue_job_role_arn

  default_arguments = {
    "--job-bookmark-option"   = var.job_bookmark_option
    "--source_database_uri"   = var.source_database_uri
    "--source_table_name"     = var.source_table_name
    "--source_user"           = var.source_user
    "--source_password"       = var.source_password
    "--destination_s3_bucket" = var.destination_s3_bucket
  }
  connections = [var.glue_connection]
  command {
    script_location = "s3://${var.glue_script_bucket}/${local.glue_script_key}"
  }

  glue_version = "2.0"
}

resource "aws_glue_catalog_database" "glue_catalog_database" {
  count = tobool(var.catalog_creation_required) ? 1 : 0
  name = var.source_database_uri 
}

resource "aws_glue_crawler" "glue_crawler" {
  count = tobool(var.crawler_required) ? 1 : 0
  schedule = var.crawler_schedule
  name = "${var.source_database_uri}-${var.source_table_name}-crawler"
  role = var.glue_job_role_arn
  database_name = var.source_database_uri
  s3_target {
    path = "s3://${trimspace(var.crawler_source_s3_bucket)}/${trimspace(var.crawler_source_s3_path)}/"
  }
}

resource "aws_glue_job" "glue_job" {
  count    = tobool(var.connection_required) ? 0 : 1
  name     = var.glue_job_name
  role_arn = var.glue_job_role_arn

  default_arguments = {
    "--job-bookmark-option"         = var.job_bookmark_option
    "--source_database_uri"         = var.source_database_uri
    "--source_table_name"           = var.source_table_name
    "--source_user"                 = var.source_user
    "--source_password"             = var.source_password
    "--destination_s3_bucket"       = var.destination_s3_bucket
  }

  command {
    script_location = "s3://${var.glue_script_bucket}/${local.glue_script_key}"
  }

  glue_version = "2.0"
}

resource "aws_glue_trigger" "glue_trigger" {
  name     = "${var.glue_job_name}_daily"
  schedule = var.glue_trigger_schedule
  type     = "SCHEDULED"

  actions {
    job_name = var.glue_job_name
  }
}

