# 🚀 ЛАЙФХАКИ ДЛЯ ЭКЗАМЕНА - БД + WPF

## 📋 БЫСТРЫЙ ЧЕКЛИСТ (делай по порядку!)

### 1️⃣ СОЗДАНИЕ БД (5 минут)
```sql
-- Всегда начинай с этого!
CREATE DATABASE ТвояБД;
USE ТвояБД;

-- Справочники ВСЕГДА ПЕРВЫЕ!
CREATE TABLE MaterialTypes (ID int IDENTITY PRIMARY KEY, Title nvarchar(100));
CREATE TABLE PartnerTypes (ID int IDENTITY PRIMARY KEY, Type nvarchar(100));

-- Потом основные таблицы
CREATE TABLE Partners (
    ID int IDENTITY PRIMARY KEY,
    Type int REFERENCES PartnerTypes(ID),
    CompanyName nvarchar(100),
    LegalAddress nvarchar(200),
    INN nvarchar(20),
    DirectorName nvarchar(100),
    Phone nvarchar(20),
    Email nvarchar(100),
    Rating int
);
```

### 2️⃣ ИМПОРТ ДАННЫХ ИЗ EXCEL
1. **Excel → Сохранить как CSV** (кодировка UTF-8!)
2. **SQL Server → Правый клик на БД → Tasks → Import Data**
3. **Источник:** Flat File Source
4. **ВАЖНО:** Проверь разделители (запятая/точка с запятой)
5. **Сначала справочники, потом основные таблицы!**

## 🔥 ЭКСТРЕННЫЕ РЕШЕНИЯ

### ❌ ОШИБКА: "Cannot insert duplicate key"
```sql
-- Проверь есть ли уже данные
SELECT * FROM твоя_таблица;
-- Если есть - удали
DELETE FROM твоя_таблица;
-- Потом импортируй заново
```

### ❌ ОШИБКА: "Foreign key constraint"
**ПОРЯДОК ИМПОРТА:**
1. MaterialTypes
2. PartnerTypes  
3. Partners
4. Products
5. PartnerProducts (ПОСЛЕДНЕЙ!)

### ❌ ОШИБКА: "String or binary data would be truncated"
```sql
-- Увеличь размер поля
ALTER TABLE Partners ALTER COLUMN CompanyName nvarchar(200);
```

## 🎯 WPF ПРИЛОЖЕНИЕ (быстрый старт)

### 1️⃣ СОЗДАНИЕ ПРОЕКТА
1. **Visual Studio → Create Project → WPF App (.NET Framework)**
2. **Name:** FloorAPP
3. **Framework:** .NET Framework 4.8

### 2️⃣ ПОДКЛЮЧЕНИЕ БД
1. **Project → Add → New Item → ADO.NET Entity Data Model**
2. **Name:** Model.edmx
3. **EF Designer from database**
4. **New Connection → SQL Server → твоя БД**
5. **Выбери ВСЕ таблицы**

### 3️⃣ МИНИМАЛЬНЫЙ КОД MainWindow.xaml.cs
```csharp
public partial class MainWindow : Window
{
    private ТвояБДEntities db = new ТвояБДEntities();
    
    public MainWindow()
    {
        InitializeComponent();
        LoadData();
    }
    
    private void LoadData()
    {
        // Для DataGrid
        dataGrid.ItemsSource = db.Partners.ToList();
    }
    
    private void AddButton_Click(object sender, RoutedEventArgs e)
    {
        // Добавление нового партнера
        var newPartner = new Partners();
        db.Partners.Add(newPartner);
        db.SaveChanges();
        LoadData(); // Обновить список
    }
    
    private void EditButton_Click(object sender, RoutedEventArgs e)
    {
        var selected = dataGrid.SelectedItem as Partners;
        if (selected != null)
        {
            // Редактирование
            db.SaveChanges();
            LoadData();
        }
    }
    
    private void DeleteButton_Click(object sender, RoutedEventArgs e)
    {
        var selected = dataGrid.SelectedItem as Partners;
        if (selected != null)
        {
            db.Partners.Remove(selected);
            db.SaveChanges();
            LoadData();
        }
    }
}
```

## 🎨 СТИЛИ (копируй-вставляй)

### MainWindow.xaml
```xml
<Window x:Class="FloorAPP.MainWindow"
        Title="Мастер пол" Height="600" Width="1000"
        Background="#FFFFFF">
    
    <Window.Resources>
        <Style TargetType="Button">
            <Setter Property="Background" Value="#67BA80"/>
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="FontFamily" Value="Segoe UI"/>
            <Setter Property="Height" Value="35"/>
            <Setter Property="Margin" Value="5"/>
        </Style>
        
        <Style TargetType="DataGrid">
            <Setter Property="Background" Value="#F4E8D3"/>
            <Setter Property="FontFamily" Value="Segoe UI"/>
        </Style>
    </Window.Resources>
    
    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
        </Grid.RowDefinitions>
        
        <StackPanel Grid.Row="0" Orientation="Horizontal" Margin="10">
            <Button Name="AddButton" Content="Добавить" Click="AddButton_Click"/>
            <Button Name="EditButton" Content="Редактировать" Click="EditButton_Click"/>
            <Button Name="DeleteButton" Content="Удалить" Click="DeleteButton_Click"/>
        </StackPanel>
        
        <DataGrid Grid.Row="1" Name="dataGrid" Margin="10" AutoGenerateColumns="False">
            <DataGrid.Columns>
                <DataGridTextColumn Header="Компания" Binding="{Binding CompanyName}"/>
                <DataGridTextColumn Header="Директор" Binding="{Binding DirectorName}"/>
                <DataGridTextColumn Header="Телефон" Binding="{Binding Phone}"/>
                <DataGridTextColumn Header="Рейтинг" Binding="{Binding Rating}"/>
            </DataGrid.Columns>
        </DataGrid>
    </Grid>
</Window>
```

## 🆘 ЕСЛИ ВСЁ СЛОМАЛОСЬ

### 1. Пересоздай проект (5 минут)
1. File → New → Project
2. Повтори шаги выше

### 2. Пересоздай БД (2 минуты)
```sql
DROP DATABASE твояБД;
-- Создай заново по скрипту выше
```

### 3. Проверь connection string
- App.config должен содержать строку подключения
- Проверь название сервера (обычно .\SQLEXPRESS)

## 💡 ПОЛЕЗНЫЕ КОМАНДЫ SQL

```sql
-- Посмотреть все таблицы
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES;

-- Посмотреть структуру таблицы
EXEC sp_help 'Partners';

-- Быстро удалить все данные
TRUNCATE TABLE Partners;

-- Проверить количество записей
SELECT COUNT(*) FROM Partners;
```

## 🎯 ПОСЛЕДНИЙ СОВЕТ

**НЕ ПАНИКУЙ!** 
- Делай по порядку
- Сначала БД, потом приложение
- Если что-то не работает - пересоздай
- Сохраняйся каждые 5 минут (Ctrl+S)

**УДАЧИ НА ЭКЗАМЕНЕ! 🍀** 