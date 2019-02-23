﻿using API;
using PlantillaMVC.Models.Binders;
using PlantillaMVC.Models.Session;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;

namespace PlantillaMVC
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            ModelBinders.Binders.Add(typeof(CarritoCompra),new CarritoCompraModelBinder());
            GlobalConfiguration.Configure(WebApiConfig.Register);//No encuentra la ruta y no se xk
            //Copiar esto del proyecto de api y en app_start coger las rutas y copiarlas
            //Crear un controller de api para que meta todas las librerias
        }
    }
}