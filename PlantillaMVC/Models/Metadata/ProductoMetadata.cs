using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace PlantillaMVC.Models
{
    public class ProductoMetadata
    {
        [Required]
        [StringLength(50,ErrorMessage ="La extensión máxima es de 50 caracteres")]
        public string Nombre;
        [Required]
        [StringLength(500, ErrorMessage = "La extensión máxima es de 500 caracteres")]
        public string Descrip;
        [Range(0,1000, ErrorMessage ="Cantidad ha de ser un valor entre 0 y 1000")]
        public int Cantidad;
        [Range(0,1000, ErrorMessage = "Precio ha de ser un valor entre 0 y 1000")]
        public float Precio;
        [RegularExpression(@"^.*\.(jpg|JPG)$", 
            ErrorMessage = "La extensión del archivo ha de ser: .jpg o .JPG")]
        public string FotoID; 
    }
}