using FloorAPP.Data;
using FloorAPP.Models;
using FloorAPP.Views;
using System;
using System.Linq;
using System.Windows;
using System.Windows.Input;

namespace FloorAPP
{
    public partial class MainWindow : Window
    {
        private MasterPoolBDEntities db = new MasterPoolBDEntities();

        public MainWindow()
        {
            InitializeComponent();
            LoadPartners(); // ← ДОБАВИТЬ!
        }

        // Загрузка партнеров
        private void LoadPartners()
        {
            try
            {
                var partners = db.Partners.Include("PartnerTypes").ToList();

                // Создаем ViewModel для каждого партнера
                var partnerViewModels = partners.Select(partner =>
                {
                    var totalSales = CalculateTotalSales(partner.Id);
                    return new PartnerViewModel(partner, totalSales);
                }).ToList();

                dgPartners.ItemsSource = partnerViewModels;
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка загрузки: {ex.Message}");
            }
        }

        // Расчет общих продаж
        private int CalculateTotalSales(int partnerId)
        {
            return db.PartnerProducts
                .Where(pp => pp.PartnerId == partnerId)
                .Sum(pp => (int?)pp.Quantity) ?? 0;
        }

        // Обработчики кнопок (добавьте если их нет)
        private void btnAdd_Click(object sender, RoutedEventArgs e)
        {
            var addWindow = new AddEditPartnerWindow();
            if (addWindow.ShowDialog() == true)
            {
                LoadPartners(); // Обновить список
            }
        }

        private void btnRefresh_Click(object sender, RoutedEventArgs e)
        {
            LoadPartners();
        }

        // Обработчик двойного клика для редактирования
        private void dgPartners_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            if (dgPartners.SelectedItem is PartnerViewModel selectedPartnerVM)
            {
                var editWindow = new AddEditPartnerWindow(selectedPartnerVM.OriginalPartner);
                if (editWindow.ShowDialog() == true)
                {
                    LoadPartners(); // Обновить список
                }
            }
        }
    }
}