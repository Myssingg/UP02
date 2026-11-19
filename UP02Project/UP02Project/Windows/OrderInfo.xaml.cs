using Microsoft.EntityFrameworkCore;
using System.Windows;
using UP02Project.Helpers;
using UP02Project.Models;

namespace UP02Project.Windows
{
    /// <summary>
    /// Логика взаимодействия для OrderInfo.xaml
    /// </summary>
    public partial class OrderInfo : Window
    {
        private readonly OrderItem? _editingOrder;

        public OrderInfo(OrderItem? orderItem = null)
        {
            InitializeComponent();
            _editingOrder = orderItem;
            LoadData();
        }

        private async void LoadData()
        {
            List<OrderStatus> orderStatuses;
            List<PickupPointItem> pickupPoints;

            try
            {
                using (Up02Context db = new Up02Context())
                {
                    orderStatuses = await db.OrderStatuses.ToListAsync();

                    var points = await db.PickupPoints
                                        .Include(p => p.City)
                                        .Include(p => p.Street)
                                        .ToListAsync();

                    pickupPoints = points
                        .Select(p => new PickupPointItem
                        {
                            Id = p.Id,
                            PickupPoint = p,
                            Address = PickupPointItem.GetAddress(p)
                        })
                        .ToList();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Не удалось загрузить данные заказа. Проверьте подключение к базе данных.\n\n" + ex.Message,
                    "Ошибка базы данных",
                    MessageBoxButton.OK,
                    MessageBoxImage.Error);
                return;
            }

            cbOrderStatus.ItemsSource = orderStatuses;
            cbPickupPoint.ItemsSource = pickupPoints;

            if (_editingOrder != null)
            {
                Title = "Редактирование заказа";
                tbOrderId.Text = _editingOrder.Id.ToString();
                dpDateOrder.SelectedDate = _editingOrder.DateOrder.ToDateTime(TimeOnly.MinValue);
                dpDeliveryDate.SelectedDate = _editingOrder.DeliveryDate?.ToDateTime(TimeOnly.MinValue);
                cbOrderStatus.SelectedValue = _editingOrder.OrderStatusId;
                cbPickupPoint.SelectedValue = _editingOrder.PickupPointId;
            }
            else
            {
                Title = "Добавление заказа";
                tbOrderIdHint.Visibility = Visibility.Visible;
                btnDelete.Visibility = Visibility.Collapsed;
            }
        }

        private async void btnSave_Click(object sender, RoutedEventArgs e)
        {
            if (cbOrderStatus.SelectedItem == null || cbPickupPoint.SelectedItem == null)
            {
                MessageBox.Show("Выберите статус заказа и пункт выдачи из выпадающих списков.",
                    "Ошибка заполнения",
                    MessageBoxButton.OK,
                    MessageBoxImage.Error);
                return;
            }

            if (dpDateOrder.SelectedDate == null)
            {
                MessageBox.Show("Укажите дату заказа. Без неё заказ сохранить нельзя.",
                    "Ошибка заполнения",
                    MessageBoxButton.OK,
                    MessageBoxImage.Error);
                return;
            }

            try
            {
                using (Up02Context db = new Up02Context())
                {
                    if (_editingOrder == null) //Новый заказ
                    {
                        Order newOrder = new Order
                        {
                            DateOrder = DateOnly.FromDateTime(dpDateOrder.SelectedDate.Value),
                            DeliveryDate = dpDeliveryDate.SelectedDate.HasValue
                                ? DateOnly.FromDateTime(dpDeliveryDate.SelectedDate.Value)
                                : null,
                            OrderStatusId = (int)cbOrderStatus.SelectedValue,
                            PickupPointId = (int)cbPickupPoint.SelectedValue,
                            UserId = Session.AutorizedUser?.Id ?? 1,
                            CodeForObtaining = new Random().Next(900, 999)
                        };

                        db.Orders.Add(newOrder);
                    }
                    else
                    {
                        Order? order = await db.Orders.FirstOrDefaultAsync(o => o.Id == _editingOrder.Id);

                        if (order == null)
                        {
                            MessageBox.Show("Заказ не найден. Возможно, он был удалён. Обновите список заказов.",
                                "Ошибка сохранения",
                                MessageBoxButton.OK,
                                MessageBoxImage.Error);
                            return;
                        }

                        order.DateOrder = DateOnly.FromDateTime(dpDateOrder.SelectedDate.Value);
                        order.DeliveryDate = dpDeliveryDate.SelectedDate.HasValue
                            ? DateOnly.FromDateTime(dpDeliveryDate.SelectedDate.Value)
                            : null;
                        order.OrderStatusId = (int)cbOrderStatus.SelectedValue;
                        order.PickupPointId = (int)cbPickupPoint.SelectedValue;
                    }

                    await db.SaveChangesAsync();
                }
            }
            catch (DbUpdateException dbEx)
            {
                MessageBox.Show("Не удалось сохранить заказ. Проверьте выбранные значения.\n\n" +
                                (dbEx.InnerException?.Message ?? dbEx.Message),
                    "Ошибка базы данных",
                    MessageBoxButton.OK,
                    MessageBoxImage.Error);
                return;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Не удалось сохранить заказ.\n\n" + ex.Message,
                    "Ошибка",
                    MessageBoxButton.OK,
                    MessageBoxImage.Error);
                return;
            }

            Close();
        }

        private async void btnDelete_Click(object sender, RoutedEventArgs e)
        {
            if (_editingOrder == null)
            {
                return;
            }

            MessageBoxResult result = MessageBox.Show($"Удалить заказ №{_editingOrder.Id}? Действие нельзя отменить.",
                "Подтверждение удаления",
                MessageBoxButton.YesNo,
                MessageBoxImage.Warning);

            if (result != MessageBoxResult.Yes)
            {
                return;
            }

            try
            {
                using (Up02Context db = new Up02Context())
                {
                    Order? order = await db.Orders
                        .Include(o => o.ProductsInOrders)
                        .FirstOrDefaultAsync(o => o.Id == _editingOrder.Id);

                    if (order != null)
                    {
                        //Сначала удаляем строки заказа, иначе внешний ключ не даст удалить заказ
                        db.ProductsInOrders.RemoveRange(order.ProductsInOrders);
                        db.Orders.Remove(order);
                        await db.SaveChangesAsync();
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Не удалось удалить заказ.\n\n" + ex.Message,
                    "Ошибка",
                    MessageBoxButton.OK,
                    MessageBoxImage.Error);
                return;
            }

            Close();
        }
    }
}
