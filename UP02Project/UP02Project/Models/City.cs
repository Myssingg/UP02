using System;
using System.Collections.Generic;

namespace UP02Project.Models;

public partial class City
{
    public int Id { get; set; }

    public string CityName { get; set; } = null!;

    public virtual ICollection<PickupPoint> PickupPoints { get; set; } = new List<PickupPoint>();
}
