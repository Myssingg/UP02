using System;
using System.Collections.Generic;

namespace UP02Project.Models;

public partial class ProductsInOrder
{
    public int Id { get; set; }

    public int OrderId { get; set; }

    public string ProductId { get; set; } = null!;

    public int Count { get; set; }

    public virtual Order Order { get; set; } = null!;

    public virtual Product Product { get; set; } = null!;
}
