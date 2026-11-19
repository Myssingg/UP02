using Microsoft.EntityFrameworkCore;
using Microsoft.Win32;
using System.Globalization;
using System.IO;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media.Imaging;
using UP02Project.Helpers;
using UP02Project.Models;

namespace UP02Project.Windows
{
    /// <summary>
    /// Логика взаимодействия для ProductInfo.xaml
    /// </summary>
    public partial class ProductInfo : Window
    {
        //Ограничение размера загружаемого изображения по заданию
        private const int MaxPictureWidth = 300;
        private const int MaxPictureHeight = 200;

        private readonly ProductItem? _item;      //Исходный товар, null при добавлении
        private readonly ProductItem _editItem;   //Редактируемая копия

        public ProductInfo(ProductItem? item = null)
        {
            InitializeComponent();

            if (item != null) //Редактирование
            {
                _item = item;
                _editItem = item.Clone();

                Title = "Редактирование товара";
                panelId.Visibility = Visibility.Visible;
                btnDelete.Visibility = Visibility.Visible;
            }
            else //Добавление
            {
                _editItem = new ProductItem { PictureName = AppPaths.DefaultPictureName };

                Title = "Добавление товара";
                //Артикул при добавлении не отображается — он вычисляется автоматически
                panelId.Visibility = Visibility.Collapsed;
                btnDelete.Visibility = Visibility.Collapsed;
            }

            DataContext = _editItem;

            LoadComboboxes();
        }

        private async void LoadComboboxes()
        {
            List<UnitsOfMeansurement> units;
            List<ProductCategory> categories;
            List<Manufacturer> manufacturers;
            List<Supplier> suppliers;

            try
            {
                using (Up02Context db = new Up02Context())
                {
                    units = await db.UnitsOfMeansurements.ToListAsync();
                    categories = await db.ProductCategories.ToListAsync();
                    manufacturers = await db.Manufacturers.ToListAsync();
                    suppliers = await db.Suppliers.ToListAsync();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Не удалось загрузить справочники. Проверьте подключение к базе данных.\n\n" + ex.Message,
                    "Ошибка базы данных",
                    MessageBoxButton.OK,
                    MessageBoxImage.Error);
                return;
            }

            cbUnitOfMeansurement.ItemsSource = units;
            cbProductCategory.ItemsSource = categories;
            cbManufacturer.ItemsSource = manufacturers;
            cbSupplier.ItemsSource = suppliers;

            if (_item != null)
            {
                //Выбираем значения по идентификатору, а не по позиции в списке
                SelectById(cbUnitOfMeansurement, units, u => u.Id, _item.UnitOfMeansurement?.Id ?? 0);
                SelectById(cbProductCategory, categories, c => c.Id, _item.Category?.Id ?? 0);
                SelectById(cbManufacturer, manufacturers, m => m.Id, _item.Manufacturer?.Id ?? 0);
                SelectById(cbSupplier, suppliers, s => s.Id, _item.Supplier?.Id ?? 0);
            }
        }

        private static void SelectById<T>(ComboBox comboBox, IEnumerable<T> source, Func<T, int> idSelector, int id)
        {
            T? item = source.FirstOrDefault(x => idSelector(x) == id);

            if (item != null)
            {
                comboBox.SelectedItem = item;
            }
        }

        private void btnChangeImg_Click(object sender, RoutedEventArgs e)
        {
            OpenFileDialog openFileDialog = new OpenFileDialog
            {
                Filter = "Изображения (*.jpg;*.jpeg;*.png)|*.jpg;*.jpeg;*.png"
            };

            if (openFileDialog.ShowDialog() != true)
            {
                return;
            }

            BitmapImage checkImage = new BitmapImage();
            checkImage.BeginInit();
            checkImage.UriSource = new Uri(openFileDialog.FileName);
            checkImage.CacheOption = BitmapCacheOption.OnLoad;
            checkImage.EndInit();

            //Ограничение размера фото 300x200
            if (checkImage.PixelWidth > MaxPictureWidth || checkImage.PixelHeight > MaxPictureHeight)
            {
                MessageBox.Show($"Размер изображения {checkImage.PixelWidth}x{checkImage.PixelHeight} превышает " +
                                $"допустимый лимит {MaxPictureWidth}x{MaxPictureHeight} пикселей. " +
                                "Выберите другое изображение.",
                    "Ошибка размера изображения",
                    MessageBoxButton.OK,
                    MessageBoxImage.Error);
                return;
            }

            string oldPictureName = _editItem.PictureName ?? AppPaths.DefaultPictureName;
            FileInfo selectedFile = new FileInfo(openFileDialog.FileName);
            string destPath = Path.Combine(AppPaths.ImagesDirectory, selectedFile.Name);

            try
            {
                //Копируем файл в папку с приложением, если он ещё не там
                if (!string.Equals(selectedFile.FullName, destPath, StringComparison.OrdinalIgnoreCase))
                {
                    selectedFile.CopyTo(destPath, true);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Не удалось сохранить изображение в папку с приложением.\n\n" + ex.Message,
                    "Ошибка сохранения изображения",
                    MessageBoxButton.OK,
                    MessageBoxImage.Error);
                return;
            }

            _editItem.PictureName = selectedFile.Name;

            //Старое изображение удаляем, если оно больше нигде не используется
            if (oldPictureName != AppPaths.DefaultPictureName
                && oldPictureName != selectedFile.Name)
            {
                DeletePictureIfUnused(oldPictureName, _item?.Id);
            }
        }

        private void btnSaveProduct_Click(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(tbProductName.Text)
                || string.IsNullOrWhiteSpace(tbPrice.Text)
                || string.IsNullOrWhiteSpace(tbDiscount.Text)
                || string.IsNullOrWhiteSpace(tbStock.Text)
                || string.IsNullOrWhiteSpace(tbDescription.Text)
                || cbUnitOfMeansurement.SelectedItem == null
                || cbProductCategory.SelectedItem == null
                || cbManufacturer.SelectedItem == null
                || cbSupplier.SelectedItem == null)
            {
                MessageBox.Show("Заполните все поля: наименование, цена, скидка, количество на складе, " +
                                "описание, единица измерения, категория, производитель и поставщик.",
                    "Ошибка заполнения",
                    MessageBoxButton.OK,
                    MessageBoxImage.Error);
                return;
            }

            //Цена может содержать копейки, поэтому принимаем и запятую, и точку
            string priceText = tbPrice.Text.Trim().Replace(',', '.');

            if (!decimal.TryParse(priceText, NumberStyles.Number, CultureInfo.InvariantCulture, out decimal productPrice)
                || productPrice < 0
                || productPrice > 1000000)
            {
                MessageBox.Show("Введите корректную цену: число от 0 до 1 000 000. " +
                                "Стоимость может содержать копейки, например 585,50.",
                    "Некорректная цена",
                    MessageBoxButton.OK,
                    MessageBoxImage.Error);
                return;
            }

            if (!int.TryParse(tbDiscount.Text.Trim(), out int productDiscount)
                || productDiscount < 0
                || productDiscount > 100)
            {
                MessageBox.Show("Введите корректную скидку: целое число от 0 до 100 процентов.",
                    "Некорректная скидка",
                    MessageBoxButton.OK,
                    MessageBoxImage.Error);
                return;
            }

            if (!int.TryParse(tbStock.Text.Trim(), out int productStock)
                || productStock < 0
                || productStock > 100000)
            {
                MessageBox.Show("Введите корректное количество на складе: целое неотрицательное число.",
                    "Некорректное количество",
                    MessageBoxButton.OK,
                    MessageBoxImage.Error);
                return;
            }

            try
            {
                using (Up02Context db = new Up02Context())
                {
                    Product editProduct;

                    if (_item != null)
                    {
                        //Артикул существующего товара не меняется
                        editProduct = db.Products.FirstOrDefault(p => p.Id == _item.Id) ?? new Product();
                        editProduct.Id = _item.Id;
                    }
                    else
                    {
                        editProduct = new Product { Id = GenerateProductId(db) };
                    }

                    editProduct.ProductName = tbProductName.Text.Trim();
                    editProduct.Price = productPrice;
                    editProduct.Discount = productDiscount;
                    editProduct.Stock = productStock;
                    editProduct.UnitOfMeansurementId = (cbUnitOfMeansurement.SelectedItem as UnitsOfMeansurement)!.Id;
                    editProduct.Description = tbDescription.Text.Trim();
                    editProduct.CategoryId = (cbProductCategory.SelectedItem as ProductCategory)!.Id;
                    editProduct.ManufacturerId = (cbManufacturer.SelectedItem as Manufacturer)!.Id;
                    editProduct.SupplierId = (cbSupplier.SelectedItem as Supplier)!.Id;
                    editProduct.PictureName = _editItem.PictureName;

                    if (_item != null)
                    {
                        db.Products.Update(editProduct);
                    }
                    else
                    {
                        db.Products.Add(editProduct);
                    }

                    db.SaveChanges();
                }
            }
            catch (DbUpdateException dbEx)
            {
                MessageBox.Show("Не удалось сохранить товар. Проверьте, что артикул не занят другим товаром, " +
                                "а все справочные значения выбраны из списка.\n\n" +
                                (dbEx.InnerException?.Message ?? dbEx.Message),
                    "Ошибка базы данных",
                    MessageBoxButton.OK,
                    MessageBoxImage.Error);
                return;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Не удалось сохранить товар.\n\n" + ex.Message,
                    "Ошибка",
                    MessageBoxButton.OK,
                    MessageBoxImage.Error);
                return;
            }

            Close();
        }

        private void btnDelete_Click(object sender, RoutedEventArgs e)
        {
            if (_item == null)
            {
                return;
            }

            try
            {
                using (Up02Context db = new Up02Context())
                {
                    //Товар, который присутствует в заказе, удалить нельзя
                    bool productInOrder = db.ProductsInOrders.Any(po => po.ProductId == _item.Id);

                    if (productInOrder)
                    {
                        MessageBox.Show($"Товар «{_item.ProductName}» присутствует в заказе, поэтому удалить его нельзя.",
                            "Удаление невозможно",
                            MessageBoxButton.OK,
                            MessageBoxImage.Warning);
                        return;
                    }
                }

                MessageBoxResult result = MessageBox.Show($"Удалить товар «{_item.ProductName}»?",
                    "Подтверждение удаления",
                    MessageBoxButton.YesNo,
                    MessageBoxImage.Question);

                if (result != MessageBoxResult.Yes)
                {
                    return;
                }

                using (Up02Context db = new Up02Context())
                {
                    Product? product = db.Products.FirstOrDefault(p => p.Id == _item.Id);

                    if (product != null)
                    {
                        db.Products.Remove(product);
                        db.SaveChanges();
                    }
                }
            }
            catch (DbUpdateException dbEx)
            {
                MessageBox.Show("Не удалось удалить товар: он используется в других записях.\n\n" +
                                (dbEx.InnerException?.Message ?? dbEx.Message),
                    "Ошибка базы данных",
                    MessageBoxButton.OK,
                    MessageBoxImage.Error);
                return;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Не удалось удалить товар.\n\n" + ex.Message,
                    "Ошибка",
                    MessageBoxButton.OK,
                    MessageBoxImage.Error);
                return;
            }

            DeletePictureIfUnused(_item.PictureName ?? AppPaths.DefaultPictureName, _item.Id);
            Close();
        }

        /// <summary>
        /// Артикул для нового товара: максимальный номер в базе плюс один.
        /// </summary>
        private static string GenerateProductId(Up02Context db)
        {
            List<string> existingIds = db.Products.Select(p => p.Id).ToList();

            int maxNumber = 0;

            foreach (string id in existingIds)
            {
                string digits = new string(id.Where(char.IsDigit).ToArray());

                if (int.TryParse(digits, out int number) && number > maxNumber)
                {
                    maxNumber = number;
                }
            }

            int nextNumber = maxNumber + 1;
            string newId = nextNumber.ToString();

            while (existingIds.Contains(newId))
            {
                nextNumber++;
                newId = nextNumber.ToString();
            }

            return newId;
        }

        /// <summary>
        /// Удаляет файл изображения, если он не используется другими товарами.
        /// </summary>
        private static void DeletePictureIfUnused(string pictureName, string? exceptProductId)
        {
            if (string.IsNullOrWhiteSpace(pictureName) || pictureName == AppPaths.DefaultPictureName)
            {
                return;
            }

            try
            {
                using (Up02Context db = new Up02Context())
                {
                    bool pictureUsed = db.Products.Any(p => p.PictureName == pictureName && p.Id != exceptProductId);

                    if (pictureUsed)
                    {
                        return;
                    }
                }

                string picturePath = Path.Combine(AppPaths.ImagesDirectory, pictureName);

                if (File.Exists(picturePath))
                {
                    File.Delete(picturePath);
                }
            }
            catch (Exception)
            {
                //Файл может быть занят другим процессом — это не критично
            }
        }
    }
}
