using Microsoft.EntityFrameworkCore;
using System.Windows;
using System.Windows.Controls;
using UP02Project.Helpers;
using UP02Project.Models;

namespace UP02Project.Windows
{
    /// <summary>
    /// Логика взаимодействия для OrderList.xaml
    /// </summary>
    public partial class OrderList : Window
    {
        private const int AdminRoleId = 1;
        private const int ManagerRoleId = 2;

        private readonly User? _autorizedUser;
        private IEnumerable<OrderItem> _allOrders = new List<OrderItem>();

        public OrderList()
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

            //Добавлять и редактировать заказы может только администратор
            if (_autorizedUser == null || _autorizedUser.RoleId != AdminRoleId)
            {
                columnAddOrder.Width = new GridLength(0);
                btnAddOrder.Visibility = Visibility.Collapsed;
            }

            _ = LoadOrders();
        }

        private async Task LoadOrders()
        {
            try
            {
                using (Up02Context db = new Up02Context())
                {
                    var orders = await db.Orders
                                        .Include(o => o.OrderStatus)
                                        .Include(o => o.PickupPoint)
                                            .ThenInclude(p => p.City)
                                        .Include(o => o.PickupPoint)
                                            .ThenInclude(p => p.Street)
                                        .Include(o => o.User)
                                        .ToListAsync();

                    _allOrders = orders.Select(o => new OrderItem
                    {
                        Id = o.Id,
                        DateOrder = o.DateOrder,
                        DeliveryDate = o.DeliveryDate,
                        OrderStatus = o.OrderStatus,
                        PickupPoint = o.PickupPoint,
                        User = o.User,
                        OrderStatusId = o.OrderStatusId,
                        PickupPointId = o.PickupPointId,
                    }).ToList();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Не удалось загрузить список заказов. Проверьте подключение к базе данных.\n\n" + ex.Message,
                    "Ошибка базы данных",
                    MessageBoxButton.OK,
                    MessageBoxImage.Error);
                _allOrders = new List<OrderItem>();
            }

            items.ItemsSource = _allOrders;
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
            //Выход на главный экран: закрываем список заказов и список товаров,
            //окно авторизации показывается в обработчиках закрытия окон
            Close();

            if (Owner is ProductList productList)
            {
                productList.Close();
            }
        }

        private async void items_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (items.SelectedIndex == -1) return;

            //Редактирование заказа доступно только администратору
            if (_autorizedUser == null || _autorizedUser.RoleId != AdminRoleId) return;

            if ((sender as ListView)?.SelectedItem is not OrderItem selectedItem) return;

            OrderInfo orderInfoWindow = new OrderInfo(selectedItem);
            orderInfoWindow.Owner = this;
            Hide();
            orderInfoWindow.ShowDialog();
            Show();

            await LoadOrders();

            items.SelectedIndex = -1;
        }

        private async void btnAddOrder_Click(object sender, RoutedEventArgs e)
        {
            //Добавление заказа доступно только администратору
            if (_autorizedUser == null || _autorizedUser.RoleId != AdminRoleId) return;

            OrderInfo orderInfoWindow = new OrderInfo();
            orderInfoWindow.Owner = this;
            Hide();
            orderInfoWindow.ShowDialog();
            Show();

            await LoadOrders();
        }
    }
}
