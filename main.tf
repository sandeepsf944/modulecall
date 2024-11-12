module "resourcegroup" {
  source             = "../modules/resourcegrop"
  rg1_name = "testrg1"
  location = "East US 2"
}


module "appserviceplan" {
  source             = "../modules/appserviceplan"
  location = module.resourcegrop.location
  linux_web_app_name = "sandeepsf94gskapp" 
  service_plan_name = "sandeepsf94gskASP"
  sku_name = "B3"
  deployed_by = "sandeep"
}

#   vpc_name      = module.alpha_vpc_1.vpc_name
#   vpc_id        = module.alpha_vpc_1.vpc_id
#   environment   = module.alpha_vpc_1.environment

module "linuxwebapp" {
  source             = "../modules/linuxwebapp"
  linux_web_app_name = "sandeepsf94gskapp"
  app_startup_command = "gunicorn -w 2 -k uvicorn.workers.UvicornWorker -b 0.0.0.0:8000 main:app"
  ftps_state = "FtpsOnly"
  scm_ip_restriction_default_action = "Allow"
  ip_restriction_default_action = "Allow"
  ip_restriction_list = ["10.1.0.0/16", "192.2.20.0/32"]
  restricted_ip_name_list = ["test1", "test2"]
  python_version = 3.9
  zip_deploy_file_path = "/msdocs-python-fastapi-webapp-quickstart.zip"
}  




