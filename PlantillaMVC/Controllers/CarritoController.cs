using PlantillaMVC.Models;
using PlantillaMVC.Models.Session;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PlantillaMVC.Controllers
{
    public class CarritoController : Controller
    {
        private TiendaFinalEntities db = new TiendaFinalEntities();
        // GET: Carrito
        public ActionResult Index(CarritoCompra cc)
        {
            return View(this.ProductList(cc));
        }

        [Authorize]
        public ActionResult Pedido(CarritoCompra cc)
        {
            Pedido pedido = new Pedido();
            pedido.IdUsuario = User.Identity.Name;
            ProductosPedidos pp = new ProductosPedidos();
            pp.Pedidoes.Add(pedido);
            List<Producto> productos = ProductList(cc);
            foreach(Producto producto in productos)
            {
                pp.Producto.Add(db.Productos.Find(producto.Id));
                pp.Cantidad_Productos = producto.Cantidad;
                //db.Productos.Find(producto.Id).Pedidoes.Add(pedido);
                //pedido.Producto.Add(db.Productos.Find(producto.Id));
                
            }
            db.Pedidoes.Add(pedido);
            db.ProductosPedidos.Add(pp);
            db.SaveChanges();
            cc.Clear();
            return RedirectToAction("Index");
        }

        private List<Producto> ProductList (CarritoCompra cc)
        {
            var res = from c in cc
                      group c by c.Id into g
                      select new { Producto = g };
            List<Producto> productos = new List<Producto>();
            foreach (var g in res)
            {
                Producto producto = new Producto();
                int cant = 0;
                foreach (var p in g.Producto)
                {
                    producto = p;
                    cant++;
                }
                producto.Cantidad = cant;
                productos.Add(producto);
            }
            return productos;
        }
    }
}