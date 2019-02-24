using Newtonsoft.Json;
using PlantillaMVC.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace PlantillaMVC.Controllers
{
    public class PedidosController : ApiController
    {
        private TiendaFinalEntities db = new TiendaFinalEntities();
        // GET: api/Pedidos
        public string Get()
        {
            List<Pedido> pedidos = db.Pedidoes.ToList();
            List<Respuesta> respuesta = new List<Respuesta>();
            foreach(Pedido pedido in pedidos)
            {
                List<ProductosPedidos> productosPedidos = pedido.ProductosPedido.ToList();
                foreach (ProductosPedidos pp in productosPedidos)
                {
                    Respuesta res = new Respuesta();
                    res.cantidad = pp.Cantidad_Productos;
                    Producto p = pp.Producto;
                    res.product_id = p.Id;
                    respuesta.Add(res);
                }
            }
            return JsonConvert.SerializeObject(respuesta);
        }

        // GET: api/Pedidos/5
        public string Get(int id)
        {
            Pedido pedido = db.Pedidoes.Find(id);
            if (pedido == null)
            {
                return JsonConvert.SerializeObject(new { });
            }
            List<ProductosPedidos> productosPedidos = pedido.ProductosPedido.ToList();
            List<Respuesta> respuesta = new List<Respuesta>();
            foreach(ProductosPedidos pp in productosPedidos)
            {
                Respuesta res = new Respuesta();
                res.cantidad = pp.Cantidad_Productos;
                Producto p = pp.Producto;
                res.product_id = p.Id;
                respuesta.Add(res);
            }
            return JsonConvert.SerializeObject(respuesta);
        }
        private class Respuesta
        {
            public int product_id { get; set; }
            public int cantidad { get; set; }
        }
    }
}
