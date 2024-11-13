module "resourcegroup" {
  source   = "../modules/resourcegrop"
  name     = "testrg"
  location = "East US 2"
  tags = {
    environment = "dev"
  }
}


module "appserviceplan" {
  source              = "../modules/appserviceplan"
  location            = module.resourcegroup.location
  resource_group_name = module.resourcegroup.resource_group_name
  service_plan_name   = "sandeepsf94gskASP"
  sku_name            = "B3"
  deployed_by         = "sandeep"
}

# #   vpc_name      = module.alpha_vpc_1.vpc_name
# #   vpc_id        = module.alpha_vpc_1.vpc_id
# #   environment   = module.alpha_vpc_1.environment

module "linuxwebapp" {
  source                                         = "../modules/linuxwebapp"
  linux_web_app_name                             = "sandeeptestwebappgsk"
  service_plan_id                                = module.appserviceplan.service_plan_id
  app_startup_command                            = "gunicorn -w 2 -k uvicorn.workers.UvicornWorker -b 0.0.0.0:8000 main:app"
  ftps_state                                     = "FtpsOnly"
  location                                       = module.resourcegroup.location
  resource_group_name                            = module.resourcegroup.resource_group_name
  scm_ip_restriction_default_action              = "Allow"
  ip_restriction_default_action                  = "Allow"
  new_ip_restriction_list                        = ["10.1.0.0/16", "192.2.20.0/32"]
  restricted_ip_name_list                        = ["test1", "test2"]
  python_version                                 = 3.9
  webdeploy_publish_basic_authentication_enabled = false
  zip_deploy_file_path                           = "./msdocs-python-fastapi-webapp-quickstart.zip"
}