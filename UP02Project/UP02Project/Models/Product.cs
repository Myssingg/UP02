using System;
using System.Collections.Generic;

namespace UP02Project.Models;

public partial class Product
{
    public string Id { get; set; } = null!;

    public string ProductName { get; set; } = null!;

    public int UnitOfMeansurementId { get; set; }

    public decimal Price { get; set; }

    public int SupplierId { get; set; }

    public int ManufacturerId { get; set; }

    public int CategoryId { get; set; }

    public int Discount { get; set; }

    public int Stock { get; set; }

    public string? Description { get; set; }

    public string? PictureName { get; set; }

    public virtual ProductCategory Category { get; set; } = null!;

    public virtual Manufacturer Manufacturer { get; set; } = null!;

    public virtual ICollection<ProductsInOrder> ProductsInOrders { get; set; } = new List<ProductsInOrder>();

    public virtual Supplier Supplier { get; set; } = null!;

    public virtual UnitsOfMeansurement UnitOfMeansurement { get; set; } = null!;
}
