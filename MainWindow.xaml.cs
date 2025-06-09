using FloorAPP.Data;
using FloorAPP.Views;
using System;
using System.Linq;
using System.Windows;

namespace FloorAPP
{
    public partial class MainWindow : Window
    {
        private MasterPoolBDEntities db = new MasterPoolBDEntities();

        public MainWindow()
        {
            InitializeComponent();
            LoadPartners();
        }

        // Загрузка партнеров
        private void LoadPartners()
        {
            try
            {
                var partners = db.Partners.Include("PartnerTypes").ToList();

                // Простое заполнение дополнительных полей
                foreach (var partner in partners)
                {
                    partner.Discount = CalculateDiscount(partner.Id);
                    partner.TypeName = partner.PartnerTypes?.TypeName ?? "";
                }

                dgPartners.ItemsSource = partners;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ошибка: " + ex.Message);
            }
        }

        // Расчет скидки
        private int CalculateDiscount(int partnerId)
        {
            var totalSales = db.PartnerProducts
                .Where(pp => pp.PartnerId == partnerId)
                .Sum(pp => (int?)pp.Quantity) ?? 0;

            if (totalSales < 10000) return 0;
            if (totalSales < 50000) return 5;
            if (totalSales < 300000) return 10;
            return 15;
        }

        // Добавить партнера
        private void btnAdd_Click(object sender, RoutedEventArgs e)
        {
            var addWindow = new AddEditPartnerWindow();
            if (addWindow.ShowDialog() == true)
            {
                LoadPartners();
            }
        }

        // Обновить список
        private void btnRefresh_Click(object sender, RoutedEventArgs e)
        {
            LoadPartners();
        }

        // История продаж
        private void btnHistory_Click(object sender, RoutedEventArgs e)
        {
            if (dgPartners.SelectedItem is Partners selectedPartner)
            {
                var historyWindow = new PartnerHistoryWindow(selectedPartner);
                historyWindow.ShowDialog();
            }
            else
            {
                MessageBox.Show("Выберите партнера!");
            }
        }

        // Двойной клик - редактировать партнера
        private void dgPartners_MouseDoubleClick(object sender, System.Windows.Input.MouseButtonEventArgs e)
        {
            if (dgPartners.SelectedItem is Partners selectedPartner)
            {
                var editWindow = new AddEditPartnerWindow(selectedPartner);
                if (editWindow.ShowDialog() == true)
                {
                    LoadPartners();
                }
            }
        }
    }
}