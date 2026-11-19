using Microsoft.EntityFrameworkCore;
using System.Windows;
using UP02Project.Helpers;
using UP02Project.Models;
using UP02Project.Windows;

namespace UP02Project
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void btnLogin_Click(object sender, RoutedEventArgs e)
        {
            string login = tbLogin.Text.Trim();
            string password = pbPassword.Password;

            if (string.IsNullOrEmpty(login) || string.IsNullOrEmpty(password))
            {
                MessageBox.Show("Введите логин и пароль. Оба поля обязательны для заполнения.",
                    "Ошибка авторизации",
                    MessageBoxButton.OK,
                    MessageBoxImage.Warning);
                return;
            }

            User? user;

            try
            {
                using (Up02Context db = new Up02Context())
                {
                    user = db.Users
                             .Include(u => u.Role)
                             .FirstOrDefault(u => u.Login == login && u.Password == password);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Не удалось подключиться к базе данных. Проверьте, что сервер БД запущен.\n\n" + ex.Message,
                    "Ошибка базы данных",
                    MessageBoxButton.OK,
                    MessageBoxImage.Error);
                return;
            }

            if (user == null)
            {
                MessageBox.Show("Пользователя с такими логином и паролем не найдено. " +
                                "Проверьте раскладку клавиатуры и регистр символов и попробуйте снова.",
                    "Ошибка авторизации",
                    MessageBoxButton.OK,
                    MessageBoxImage.Error);
                return;
            }

            Session.AutorizedUser = user;

            ProductList productList = new ProductList();
            productList.Owner = this;
            productList.Show();
            Hide();

            tbLogin.Clear();
            pbPassword.Clear();
        }

        private void btnWatchProducts_Click(object sender, RoutedEventArgs e)
        {
            //Гость: просмотр товаров без фильтрации, сортировки и поиска
            Session.AutorizedUser = new User { Id = -1 };

            ProductList productList = new ProductList();
            productList.Owner = this;
            productList.Show();
            Hide();

            tbLogin.Clear();
            pbPassword.Clear();
        }
    }
}
