using System;
using System.Collections.Generic;
using System.Text;
using UP02Project.Models;

namespace UP02Project.Helpers
{
    public class OrderItem
    {
        public int Id { get; set; }
        public DateOnly DateOrder { get; set; }
        public DateOnly? DeliveryDate { get; set; }

        public virtual OrderStatus OrderStatus { get; set; }
        public virtual PickupPoint PickupPoint { get; set; }
        public virtual User User { get; set; }

        public int OrderStatusId { get; set; }
        public int PickupPointId { get; set; }

        public string Address
        {
            get
            {
                return PickupPointItem.GetAddress(PickupPoint);
            }
        }
    }
}
