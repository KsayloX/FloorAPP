using FloorAPP.Data;
using System.Linq;
using System.Windows;

namespace FloorAPP
{
    public partial class PartnerHistoryWindow : Window
    {
        private MasterPoolBDEntities db = new MasterPoolBDEntities();

        public PartnerHistoryWindow(Partners partner)
        {
            InitializeComponent();

            Title = partner.CompanyName + " - История продаж";
            txtTitle.Text = $"История продаж партнера: {partner.CompanyName}";

            var history = db.PartnerProducts
                .Include("Products")
                .Where(pp => pp.PartnerId == partner.Id)
                .ToList();

            dgHistory.ItemsSource = history;
        }

        private void btnClose_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }
    }
}