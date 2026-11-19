using UP02Project.Models;

namespace UP02Project.Helpers
{
    public class PickupPointItem
    {
        public int Id { get; set; }
        public PickupPoint PickupPoint { get; set; }
        public string Address { get; set; }

        public static string GetAddress(PickupPoint point)
        {
            if (point == null) return "";

            string city = point.City != null ? $"г. {point.City.CityName}" : "";
            string street = point.Street != null ? $"ул. {point.Street.StreetName}" : "";
            string house = !string.IsNullOrWhiteSpace(point.HouseNumber)
                ? $"д. {point.HouseNumber}"
                : "";

            return string.Join(", ", new[] { point.Index, city, street, house }
                .Where(s => !string.IsNullOrWhiteSpace(s)));
        }
    }
}