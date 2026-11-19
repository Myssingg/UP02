using System.ComponentModel;
using System.IO;
using System.Runtime.CompilerServices;
using UP02Project.Models;

namespace UP02Project.Helpers
{
    public class ProductItem : INotifyPropertyChanged
    {
        public string Id { get; set; } = null!;
        public string ProductName { get; set; } = null!;
        public decimal Price { get; set; }
        public int Discount { get; set; }
        public int Stock { get; set; }
        public string? Description { get; set; }

        private string? _pictureName;
        public string? PictureName
        {
            get
            {
                return string.IsNullOrWhiteSpace(_pictureName)
                    ? AppPaths.DefaultPictureName
                    : _pictureName;
            }
            set
            {
                _pictureName = value;
                OnPropertyChanged();
                OnPropertyChanged(nameof(ImgPath)); //Картинка автоматически перерисуется в интерфейсе
            }
        }

        public virtual ProductCategory Category { get; set; } = null!;
        public virtual Manufacturer Manufacturer { get; set; } = null!;
        public virtual Supplier Supplier { get; set; } = null!;
        public virtual UnitsOfMeansurement UnitOfMeansurement { get; set; } = null!;

        public decimal DiscountPrice
        {
            get
            {
                return Price * (100 - Discount) / 100;
            }
        }

        public bool HasDiscount
        {
            get
            {
                return Discount > 0;
            }
        }

        public bool IsDiscontMoreThan25
        {
            get { return Discount > 25; }
        }

        public bool IsProductAbsent
        {
            get { return Stock == 0; }
        }

        public string? ImgPath
        {
            get
            {
                string baseImagesDir = AppPaths.ImagesDirectory;
                string defaultImage = AppPaths.DefaultPicturePath;

                if (string.IsNullOrWhiteSpace(PictureName))
                {
                    return defaultImage;
                }

                string candidate = Path.Combine(baseImagesDir, PictureName);

                //Если файла нет, показываем картинку-заглушку из ресурсов
                return File.Exists(candidate) ? candidate : defaultImage;
            }

            set
            {
                if (string.IsNullOrWhiteSpace(value))
                {
                    return;
                }

                PictureName = new FileInfo(value).Name;
            }
        }

        public ProductItem Clone()
        {
            return (ProductItem)MemberwiseClone();
        }

        public event PropertyChangedEventHandler? PropertyChanged;
        protected void OnPropertyChanged([CallerMemberName] string? prop = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(prop));
        }
    }
}
