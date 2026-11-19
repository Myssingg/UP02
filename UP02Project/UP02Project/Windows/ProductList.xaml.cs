using Microsoft.EntityFrameworkCore;
using System.Windows;
using System.Windows.Controls;
using UP02Project.Helpers;
using UP02Project.Models;

namespace UP02Project.Windows
{
    /// <summary>
    /// Логика взаимодействия для ProductList.xaml
    /// </summary>
    public partial class ProductList : Window
    {
        //Идентификаторы ролей из таблицы Roles
        private const int AdminRoleId = 1;
        private const int ManagerRoleId = 2;

        private readonly User? _autorizedUser;
        private List<ProductItem> _allProducts = new List<ProductItem>();

        public ProductList()
        {
            InitializeComponent();

            _autorizedUser = Session.AutorizedUser;

            if (_autorizedUser == null || _autorizedUser.Id == -1)
            {
                userRole.Text = "Гость";
                userFIO.Text = "Гость";
            }
            else
            {
                userRole.Text = _autorizedUser.Role.RoleName;
                userFIO.Text = _autorizedUser.Fio;
            }

            filterPanel.Visibility = Visibility.Collapsed;
            filterPanelAdministrator.Visibility = Visibility.Collapsed;

            _ = LoadDataAsync();
        }

        private bool IsAdmin => _autorizedUser != null && _autorizedUser.RoleId == AdminRoleId;

        private bool IsManager => _autorizedUser != null && _autorizedUser.RoleId == ManagerRoleId;

        private async Task LoadDataAsync()
        {
            await LoadComboboxes();
            await LoadProducts();
        }

        private async Task LoadProducts()
        {
            try
            {
                using (Up02Context db = new Up02Context())
                {
                    var products = await db.Products
                                        .Include(p => p.UnitOfMeansurement)
                                        .Include(p => p.Category)
                                        .Include(p => p.Manufacturer)
                                        .Include(p => p.Supplier)
                                        .ToListAsync();

                    _allProducts = products.Select(p => new ProductItem
                    {
                        Id = p.Id,
                        ProductName = p.ProductName,
                        Price = p.Price,
                        Discount = p.Discount,
                        Stock = p.Stock,
                        Description = p.Description,
                        PictureName = p.PictureName,

                        Category = p.Category,
                        Manufacturer = p.Manufacturer,
                        Supplier = p.Supplier,
                        UnitOfMeansurement = p.UnitOfMeansurement
                    }).ToList();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Не удалось загрузить список товаров. Проверьте подключение к базе данных.\n\n" + ex.Message,
                    "Ошибка базы данных",
                    MessageBoxButton.OK,
                    MessageBoxImage.Error);
                _allProducts = new List<ProductItem>();
            }

            ApplyFilters();
        }

        private async Task LoadComboboxes()
        {
            //Фильтрация, сортировка и поиск доступны только менеджеру и администратору
            if (IsAdmin || IsManager)
            {
                filterPanel.Visibility = Visibility.Visible;
                filterPanelAdministrator.Visibility = Visibility.Visible;

                try
                {
                    using (Up02Context db = new Up02Context())
                    {
                        cbSuppliers.ItemsSource = await db.Suppliers.ToListAsync();
                        cbManufacturers.ItemsSource = await db.Manufacturers.ToListAsync();
                        cbCategories.ItemsSource = await db.ProductCategories.ToListAsync();
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Не удалось загрузить данные для фильтрации.\n\n" + ex.Message,
                        "Ошибка базы данных",
                        MessageBoxButton.OK,
                        MessageBoxImage.Error);
                }

                cbSortingCategory.Items.Add("По умолчанию");
                cbSortingCategory.Items.Add("Цена");
                cbSortingCategory.Items.Add("Количество на складе");
                cbSortingCategory.SelectedIndex = 0;

                cbSortingType.Items.Add("По возрастанию");
                cbSortingType.Items.Add("По убыванию");
                cbSortingType.SelectedIndex = 0;

                cbActiveDiscount.Items.Add("Все диапазоны");
                cbActiveDiscount.Items.Add("0-12,99%");
                cbActiveDiscount.Items.Add("13-16,99%");
                cbActiveDiscount.Items.Add("17% и более");
                cbActiveDiscount.SelectedIndex = 0;
            }

            //Добавление товаров доступно только администратору
            if (!IsAdmin)
            {
                columnAddProduct.Width = new GridLength(0);
                btnAddProduct.Visibility = Visibility.Collapsed;
            }

            //Заказы доступны администратору и менеджеру
            if (!IsAdmin && !IsManager)
            {
                columnToOrders.Width = new GridLength(0);
                btnToOrders.Visibility = Visibility.Collapsed;
            }
        }

        private void ApplyFilters()
        {
            IEnumerable<ProductItem> filteredList = _allProducts;

            string search = tbSearch?.Text?.Trim().ToLower() ?? "";

            //Поиск сразу по нескольким атрибутам одновременно
            if (search.Length > 0)
            {
                filteredList = filteredList.Where(p => GetSearchText(p).Contains(search));
            }

            if (cbSuppliers?.SelectedItem is Supplier supplier)
            {
                filteredList = filteredList.Where(p => p.Supplier != null && p.Supplier.Id == supplier.Id);
            }

            if (cbManufacturers?.SelectedItem is Manufacturer manufacturer)
            {
                filteredList = filteredList.Where(p => p.Manufacturer != null && p.Manufacturer.Id == manufacturer.Id);
            }

            if (cbCategories?.SelectedItem is ProductCategory productCategory)
            {
                filteredList = filteredList.Where(p => p.Category != null && p.Category.Id == productCategory.Id);
            }

            //Сортировка по выбранному столбцу и направлению
            int sortingCategory = cbSortingCategory?.SelectedIndex ?? 0;
            int sortingType = cbSortingType?.SelectedIndex ?? 0;

            if (sortingCategory == 1) //Цена
            {
                filteredList = sortingType == 0
                    ? filteredList.OrderBy(p => p.DiscountPrice)
                    : filteredList.OrderByDescending(p => p.DiscountPrice);
            }

            if (sortingCategory == 2) //Количество на складе
            {
                filteredList = sortingType == 0
                    ? filteredList.OrderBy(p => p.Stock)
                    : filteredList.OrderByDescending(p => p.Stock);
            }

            //Фильтр по размеру действующей скидки, "Все диапазоны" ничего не отсекает
            if (cbActiveDiscount?.SelectedIndex == 1) //0 - 12,99%
            {
                filteredList = filteredList.Where(p => p.Discount >= 0 && p.Discount < 13);
            }

            if (cbActiveDiscount?.SelectedIndex == 2) //13 - 16,99%
            {
                filteredList = filteredList.Where(p => p.Discount >= 13 && p.Discount < 17);
            }

            if (cbActiveDiscount?.SelectedIndex == 3) //17% и более
            {
                filteredList = filteredList.Where(p => p.Discount >= 17);
            }

            List<ProductItem> result = filteredList.ToList();

            items.ItemsSource = result;
            tbEmptyList.Visibility = result.Count == 0 ? Visibility.Visible : Visibility.Collapsed;
        }

        /// <summary>
        /// Все текстовые данные товара одной строкой — для поиска по нескольким атрибутам сразу.
        /// </summary>
        private static string GetSearchText(ProductItem product)
        {
            string[] values =
            {
                product.ProductName ?? "",
                product.Description ?? "",
                product.Category?.CategoryName ?? "",
                product.Manufacturer?.ManufacturerName ?? "",
                product.Supplier?.SupplierName ?? "",
                product.UnitOfMeansurement?.Name ?? ""
            };

            return string.Join(" ", values).ToLower();
        }

        private void Window_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            if (Owner != null)
            {
                Owner.Show();
            }
        }

        private void btnLogout_Click(object sender, RoutedEventArgs e)
        {
            if (Owner != null)
            {
                Owner.Show();
            }
            Close();
        }

        private void tbSearch_TextChanged(object sender, TextChangedEventArgs e)
        {
            ApplyFilters();
        }

        private void btnClearFilters_Click(object sender, RoutedEventArgs e)
        {
            //Сбрасываем все параметры фильтрации, поиска и сортировки
            cbCategories.SelectedIndex = -1;
            cbManufacturers.SelectedIndex = -1;
            cbSuppliers.SelectedIndex = -1;
            cbActiveDiscount.SelectedIndex = 0;
            cbSortingCategory.SelectedIndex = 0;
            cbSortingType.SelectedIndex = 0;
            tbSearch.Clear();

            ApplyFilters();
        }

        private void cbFilters_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            ApplyFilters();
        }

        private async void items_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (items.SelectedIndex == -1) return;

            //Редактирование товара доступно только администратору
            if (!IsAdmin) return;

            if ((sender as ListView)?.SelectedItem is not ProductItem selectedItem) return;

            ProductInfo productInfoWindow = new ProductInfo(selectedItem);
            productInfoWindow.Owner = this;
            Hide();
            productInfoWindow.ShowDialog();
            Show();

            await LoadProducts();

            items.SelectedIndex = -1;
        }

        private async void btnAddProduct_Click(object sender, RoutedEventArgs e)
        {
            //Добавление товара доступно только администратору
            if (!IsAdmin) return;

            ProductInfo productInfoWindow = new ProductInfo();
            productInfoWindow.Owner = this;
            Hide();
            productInfoWindow.ShowDialog();
            Show();

            await LoadProducts();
        }

        private void btnToOrders_Click(object sender, RoutedEventArgs e)
        {
            //Заказы доступны администратору и менеджеру
            if (!IsAdmin && !IsManager) return;

            OrderList orderListWindow = new OrderList();
            orderListWindow.Owner = this;
            Hide();
            orderListWindow.Show();
        }
    }
}
