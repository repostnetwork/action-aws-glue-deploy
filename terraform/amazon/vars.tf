variable "region" {
  default = "us-east-1"
}

variable "env" {
  description = "Either 'staging' or 'production'"
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

variable "source_database_name" {
  description = "The source database name argument that should be passed to the Glue job's script"
}

variable "source_table_name" {
  description = "The source table name argument that should be passed to the Glue job's script"
}

variable "source_user" {
  description = "The source database user argument that should be passed to the Glue job's script"
}

variable "destination_s3_bucket" {
  description = "The destination S3 bucket name argument that should be passed to the Glue job's script"
}

provider "aws" {
  version = ">= 1.47.0"
  profile = "default"
  region  = "${var.region}"
}

terraform {
  backend "s3" {
    encrypt = true
    region  = "us-east-1"
  }
}
