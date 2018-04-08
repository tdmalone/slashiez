/**
 * Main Terraform configuration for Slashies.
 *
 * Because Slashies was originally written in PHP, it utilises Azure functions which do support
 * PHP. Terraform state is stored in an AWS S3 bucket.
 *
 * @author Tim Malone <tdmalone@gmail.com>
 */

/**
 * Configure the Azure Provider, with version constraints.
 * Credentials are handled by the Azure CLI (az login).
 *
 * @see https://www.terraform.io/docs/providers/azurerm/index.html
 * @see https://www.terraform.io/docs/configuration/providers.html#provider-versions
 */
provider "azurerm" {
  version = "~> 1.3"
}

/**
 * AWS provider configuration, with version constraints.
 * Credentials are taken from the usual AWS environment variables.
 *
 * @see https://www.terraform.io/docs/providers/aws/index.html
 * @see https://www.terraform.io/docs/configuration/providers.html#provider-versions
 */
provider "aws" {
  region  = "ap-southeast-2"
  version = "~> 1.12"
}

/**
 * Configure Terraform backend for storing state.
 * Some resources utilised here are managed by tdmalone/timfrastructure.
 *
 * When running `terraform plan` for the first time, you'll want to comment out the `terraform`
 * object below and allow the default, local backend to be used at first, so that the neccessary
 * resource(s) can be created.
 *
 * @see https://www.terraform.io/docs/backends/types/s3.html
 * @see https://github.com/tdmalone/timfrastructure/blob/master/config.tf
 * @see https://www.terraform.io/docs/providers/aws/r/dynamodb_table.html
 */
terraform {
  backend "s3" {
    bucket         = "timfrastructure"
    key            = "slashies-tfstate"
    encrypt        = true
    dynamodb_table = "slashies-tfstate"
  }
}

resource "aws_dynamodb_table" "tfstate" {
  name           = "slashies-tfstate"
  hash_key       = "LockID"
  read_capacity  = 1
  write_capacity = 1

  attribute {
    name = "LockID"
    type = "S"
  }
}

/**
 * Create an Azure resource group, closest to Slack's us-east-1 in AWS.
 * To view location names, run `az functionapp list-consumption-locations`.
 *
 * @see https://www.terraform.io/docs/providers/azurerm/r/resource_group.html
 */
resource "azurerm_resource_group" "main" {
  name     = "main-resource-group"
  location = "eastus"
}

/**
 * Create an Azure storage account.
 *
 * @see https://www.terraform.io/docs/providers/azurerm/r/storage_account.html
 */
resource "azurerm_storage_account" "main" {
  name                     = "slashies"
  resource_group_name      = "${azurerm_resource_group.main.name}"
  location                 = "${azurerm_resource_group.main.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

/**
 * Create an Azure app service plan.
 * To view available SKU's run 'az vm list-skus --output table'
 *
 * @see https://www.terraform.io/docs/providers/azurerm/r/app_service_plan.html
 */
resource "azurerm_app_service_plan" "main" {
  name                = "main-service-plan"
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"
  kind                = "FunctionApp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

/**
 * Create a function app for Slashies!
 *
 * @see https://www.terraform.io/docs/providers/azurerm/r/function_app.html
 */
resource "azurerm_function_app" "slashies" {
  name                      = "slashies"
  location                  = "${azurerm_resource_group.main.location}"
  resource_group_name       = "${azurerm_resource_group.main.name}"
  app_service_plan_id       = "${azurerm_app_service_plan.main.id}"
  storage_connection_string = "${azurerm_storage_account.main.primary_connection_string}"
}
