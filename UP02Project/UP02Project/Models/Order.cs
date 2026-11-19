using System;
using System.Collections.Generic;

namespace UP02Project.Models;

public partial class Order
{
    public int Id { get; set; }

    public DateOnly DateOrder { get; set; }

    public DateOnly? DeliveryDate { get; set; }

    public int PickupPointId { get; set; }

    public int UserId { get; set; }

    public int CodeForObtaining { get; set; }

    public int OrderStatusId { get; set; }

    public virtual OrderStatus OrderStatus { get; set; } = null!;

    public virtual PickupPoint PickupPoint { get; set; } = null!;

    public virtual ICollection<ProductsInOrder> ProductsInOrders { get; set; } = new List<ProductsInOrder>();

    public virtual User User { get; set; } = null!;
}
