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
            List<Producto> productos = ProductList(cc);
            foreach(Producto producto in productos)
            {
                ProductosPedidos pp = new ProductosPedidos();
                pp.Producto = db.Productos.Find(producto.Id);
                pp.Cantidad_Productos = producto.Cantidad;
                pp.Pedidoes.Add(pedido);
                db.ProductosPedidos.Add(pp);
            }
            db.Pedidoes.Add(pedido);
            foreach(Producto producto in productos)
            {
                Producto productodb = db.Productos.Find(producto.Id);
                productodb.Cantidad -= producto.Cantidad;
                if (productodb.Cantidad <= 2)
                {
                    Stock stock = new Stock();
                    stock.Productoes = productodb;
                    stock.Reabastecido = false;
                    db.Stocks.Add(stock);
                }
            }
            db.SaveChanges();
            cc.Clear();
            return RedirectToAction("Index");
        }
        public ActionResult Remove(int id, CarritoCompra cc)
        {
            Producto producto=new Producto();
            foreach (var p in cc)
            {
                if (p.Id == id)
                    producto = p;
            }
            cc.Remove(producto);
            return RedirectToAction("Index");
        }
        public ActionResult RemoveAll(int id, CarritoCompra cc)
        {
            List<Producto> productos = new List<Producto>();
            foreach (var p in cc)
            {
                if (p.Id == id)
                    productos.Add(p);
            }
            foreach(Producto p in productos)
                cc.Remove(p);
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