using System;
using System.Collections.Generic;

namespace UP02Project.Models;

public partial class Street
{
    public int Id { get; set; }

    public string StreetName { get; set; } = null!;

    public virtual ICollection<PickupPoint> PickupPoints { get; set; } = new List<PickupPoint>();
}
