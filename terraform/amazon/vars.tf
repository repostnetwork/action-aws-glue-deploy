variable "region" {
  default = "us-east-1"
}

variable "env" {
  description = "Either 'staging' or 'production'"
}

variable "bucket" {
  description = "The s3 bucket to be used for terraform state"
}

variable "glue_script_bucket" {
  description = "The bucket where the Glue job's script will be stored"
}

variable "glue_script_local_path" {
  description = "The local path to the Glue job's script"
}

variable "glue_job_name" {
  description = "The name of the Glue job"
}

variable "glue_job_role_arn" {
  description = "ARN of the IAM role that should run the Glue job"
}

variable "source_database_uri" {
  description = "The source database URI argument that should be passed to the Glue job's script"
}

variable "source_table_name" {
  description = "The source table name argument that should be passed to the Glue job's script"
}

variable "source_user" {
  description = "The source database user argument that should be passed to the Glue job's script"
}

variable "source_password" {
  description = "The source database password argument that should be passed to the Glue job's script"
}

variable "destination_s3_bucket" {
  description = "The destination S3 bucket name argument that should be passed to the Glue job's script"
}

variable "glue_connection" {
  description = "The Glue connection required for this job, if applicable"
}

variable "connection_required" {
  description = "'true' if a connection is required for this job, 'false' otherwise"
  default = false
}

provider "aws" {
  version = ">= 1.47.0"
  profile = "default"
  region  = var.region
}

terraform {
  backend "s3" {
    encrypt = true
    region  = "us-east-1"
  }
}
