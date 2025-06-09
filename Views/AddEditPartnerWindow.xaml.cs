using FloorAPP.Data;
using System;
using System.Linq;
using System.Windows;

namespace FloorAPP.Views
{
    /// <summary>
    /// Логика взаимодействия для AddEditPartnerWindow.xaml
    /// </summary>
    public partial class AddEditPartnerWindow : Window
    {
        private MasterPoolBDEntities db = new MasterPoolBDEntities();
        private Partners partner;

        // Для добавления
        public AddEditPartnerWindow()
        {
            InitializeComponent();
            Title = "Добавление партнера";
            cmbPartnerType.ItemsSource = db.PartnerTypes.ToList();
        }

        // Для редактирования
        public AddEditPartnerWindow(Partners editPartner) : this()
        {
            partner = editPartner;
            Title = "Редактирование партнера";
            
            // Заполняем поля
            txtTitle.Text = partner.CompanyName;
            cmbPartnerType.SelectedValue = partner.PartnerTypeId;
            txtRating.Text = partner.Rating.ToString();
            txtAddress.Text = partner.Address;
            txtDirector.Text = partner.DirectorName;
            txtPhone.Text = partner.Phone;
            txtEmail.Text = partner.Email;
        }

        private void btnSave_Click(object sender, RoutedEventArgs e)
        {
            // Простая проверка
            if (string.IsNullOrEmpty(txtTitle.Text) || cmbPartnerType.SelectedValue == null)
            {
                MessageBox.Show("Заполните обязательные поля!");
                return;
            }

            try
            {
                if (partner == null) // Добавление
                {
                    partner = new Partners();
                    db.Partners.Add(partner);
                }

                // Заполняем данные
                partner.CompanyName = txtTitle.Text;
                partner.PartnerTypeId = (int)cmbPartnerType.SelectedValue;
                partner.Rating = int.Parse(txtRating.Text ?? "0");
                partner.Address = txtAddress.Text ?? "";
                partner.DirectorName = txtDirector.Text ?? "";
                partner.Phone = txtPhone.Text ?? "";
                partner.Email = txtEmail.Text ?? "";
                partner.INN = partner.INN ?? "";

                db.SaveChanges();
                DialogResult = true;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ошибка: " + ex.Message);
            }
        }

        private void btnCancel_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }
    }
}
