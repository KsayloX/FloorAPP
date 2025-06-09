using FloorAPP.Data;

namespace FloorAPP.Models
{
    /// <summary>
    /// Класс для отображения партнера в UI с дополнительными вычисляемыми свойствами
    /// </summary>
    public class PartnerViewModel
    {
        private readonly Partners _partner;

        public PartnerViewModel(Partners partner, int totalSales)
        {
            _partner = partner;
            TotalSales = totalSales;
            Discount = CalculateDiscount(totalSales);
        }

        // Основные свойства партнера
        public int Id => _partner.Id;
        public string CompanyName => _partner.CompanyName;
        public string Title => _partner.CompanyName; // Для совместимости с XAML
        public int PartnerTypeId => _partner.PartnerTypeId;
        public string DirectorName => _partner.DirectorName;
        public string Email => _partner.Email;
        public string Phone => _partner.Phone;
        public string Address => _partner.Address;
        public string INN => _partner.INN;
        public int Rating => _partner.Rating;

        // Связанные объекты
        public PartnerTypes PartnerTypes => _partner.PartnerTypes;
        public PartnerTypes PartnerType => _partner.PartnerTypes; // Для совместимости с XAML биндингом
        
        // Дополнительные свойства для удобства биндинга
        public string TypeName => _partner.PartnerTypes?.TypeName ?? "Не указан";

        // Вычисляемые свойства
        public int TotalSales { get; }
        public int Discount { get; }

        // Ссылка на оригинальный объект для редактирования
        public Partners OriginalPartner => _partner;

        /// <summary>
        /// Расчет скидки на основе общих продаж
        /// </summary>
        private static int CalculateDiscount(int totalSales)
        {
            if (totalSales < 10000) return 0;
            if (totalSales < 50000) return 5;
            if (totalSales < 300000) return 10;
            return 15;
        }
    }
}