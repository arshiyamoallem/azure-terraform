resource "azurerm_resource_group" "rg" {
  name     = "arshiya-tf-rg"
  location = "westus"
}

resource "azurerm_service_plan" "asp" {
  name                = "arshiya-tf-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku_name = "F1"  # Free tier
  os_type  = "Linux"
}

resource "azurerm_linux_web_app" "webapp" {
  name                = "arshiya-tf-webapp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    always_on = false  # FREE tier requires this

    application_stack {
      python_version = "3.10"
    }
  }
}
