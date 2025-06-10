-- ===================================================================
-- СОЗДАНИЕ БАЗЫ ДАННЫХ В 3НФ
-- Скрипт создания таблиц в правильной последовательности
-- ===================================================================

USE master;
GO

-- Создаём базу данных
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'PartnersProductsDB')
BEGIN
    CREATE DATABASE PartnersProductsDB;
END
GO

USE PartnersProductsDB;
GO

-- ===================================================================
-- 1. СПРАВОЧНЫЕ ТАБЛИЦЫ (создаём первыми - они не зависят от других)
-- ===================================================================

-- Справочник типов материалов
CREATE TABLE MaterialTypes (
    MaterialTypeID INT IDENTITY(1,1) PRIMARY KEY,
    MaterialTypeName NVARCHAR(100) NOT NULL UNIQUE,
    DefectPercentage DECIMAL(5,2) NOT NULL CHECK (DefectPercentage >= 0 AND DefectPercentage <= 100),
    CreatedAt DATETIME2 DEFAULT GETDATE(),
    IsActive BIT DEFAULT 1
);

-- Справочник типов партнёров  
CREATE TABLE PartnerTypes (
    PartnerTypeID INT IDENTITY(1,1) PRIMARY KEY,
    PartnerTypeName NVARCHAR(50) NOT NULL UNIQUE,
    CreatedAt DATETIME2 DEFAULT GETDATE(),
    IsActive BIT DEFAULT 1
);

-- Справочник типов продукции
CREATE TABLE ProductTypes (
    ProductTypeID INT IDENTITY(1,1) PRIMARY KEY,
    ProductTypeName NVARCHAR(100) NOT NULL UNIQUE,
    ProductCoefficient DECIMAL(10,4) NOT NULL CHECK (ProductCoefficient > 0),
    CreatedAt DATETIME2 DEFAULT GETDATE(),
    IsActive BIT DEFAULT 1
);

-- ===================================================================
-- 2. ОСНОВНЫЕ СУЩНОСТИ (зависят от справочников)
-- ===================================================================

-- Партнёры
CREATE TABLE Partners (
    PartnerID INT IDENTITY(1,1) PRIMARY KEY,
    PartnerTypeID INT NOT NULL,
    PartnerName NVARCHAR(200) NOT NULL,
    DirectorName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(20) NOT NULL,
    LegalAddress NVARCHAR(500) NOT NULL,
    INN NVARCHAR(12) NOT NULL UNIQUE,
    Rating INT NOT NULL CHECK (Rating >= 1 AND Rating <= 10),
    CreatedAt DATETIME2 DEFAULT GETDATE(),
    UpdatedAt DATETIME2 DEFAULT GETDATE(),
    IsActive BIT DEFAULT 1,
    
    CONSTRAINT FK_Partners_PartnerType 
        FOREIGN KEY (PartnerTypeID) REFERENCES PartnerTypes(PartnerTypeID)
);

-- Продукция
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductTypeID INT NOT NULL,
    ProductName NVARCHAR(200) NOT NULL,
    Article NVARCHAR(50) NOT NULL UNIQUE,
    MinPriceForPartner DECIMAL(18,2) NOT NULL CHECK (MinPriceForPartner > 0),
    CreatedAt DATETIME2 DEFAULT GETDATE(),
    UpdatedAt DATETIME2 DEFAULT GETDATE(),
    IsActive BIT DEFAULT 1,
    
    CONSTRAINT FK_Products_ProductType 
        FOREIGN KEY (ProductTypeID) REFERENCES ProductTypes(ProductTypeID)
);

-- ===================================================================
-- 3. СВЯЗУЮЩИЕ ТАБЛИЦЫ (many-to-many отношения)
-- ===================================================================

-- Продажи партнёрам (связь продукции и партнёров)
CREATE TABLE PartnerSales (
    SaleID INT IDENTITY(1,1) PRIMARY KEY,
    PartnerID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    UnitPrice DECIMAL(18,2) NOT NULL CHECK (UnitPrice > 0),
    TotalAmount AS (Quantity * UnitPrice) PERSISTED,
    SaleDate DATETIME2 NOT NULL DEFAULT GETDATE(),
    CreatedAt DATETIME2 DEFAULT GETDATE(),
    
    CONSTRAINT FK_PartnerSales_Partner 
        FOREIGN KEY (PartnerID) REFERENCES Partners(PartnerID),
    CONSTRAINT FK_PartnerSales_Product 
        FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- ===================================================================
-- 4. ИНДЕКСЫ ДЛЯ ПРОИЗВОДИТЕЛЬНОСТИ
-- ===================================================================

-- Индексы для поиска и JOIN'ов
CREATE NONCLUSTERED INDEX IX_Partners_PartnerType 
    ON Partners(PartnerTypeID) INCLUDE (PartnerName, Rating);

CREATE NONCLUSTERED INDEX IX_Partners_Rating 
    ON Partners(Rating DESC) INCLUDE (PartnerName, PartnerTypeID);

CREATE NONCLUSTERED INDEX IX_Products_ProductType 
    ON Products(ProductTypeID) INCLUDE (ProductName, Article);

CREATE NONCLUSTERED INDEX IX_Products_Article 
    ON Products(Article) INCLUDE (ProductName, MinPriceForPartner);

CREATE NONCLUSTERED INDEX IX_PartnerSales_Partner 
    ON PartnerSales(PartnerID) INCLUDE (ProductID, Quantity, SaleDate);

CREATE NONCLUSTERED INDEX IX_PartnerSales_Product 
    ON PartnerSales(ProductID) INCLUDE (PartnerID, Quantity, SaleDate);

CREATE NONCLUSTERED INDEX IX_PartnerSales_Date 
    ON PartnerSales(SaleDate DESC) INCLUDE (PartnerID, ProductID, TotalAmount);

-- ===================================================================
-- 5. ПРИМЕРЫ ЗАПОЛНЕНИЯ ДАННЫХ (для тестирования)
-- ===================================================================

-- Типы материалов
INSERT INTO MaterialTypes (MaterialTypeName, DefectPercentage) VALUES
('Пластик', 2.5),
('Металл', 1.2),
('Дерево', 3.8),
('Стекло', 0.8);

-- Типы партнёров
INSERT INTO PartnerTypes (PartnerTypeName) VALUES
('ООО'),
('ЗАО'),
('ПАО'),
('ИП');

-- Типы продукции
INSERT INTO ProductTypes (ProductTypeName, ProductCoefficient) VALUES
('Паркетная доска', 2.3520),
('Ламинат', 1.7820),
('Массивная доска', 4.0780);

-- Партнёры
INSERT INTO Partners (PartnerTypeID, PartnerName, DirectorName, Email, Phone, LegalAddress, INN, Rating) VALUES
(1, 'База Строитель', 'Иванова Александра Ивановна', 'aleksandraivanova@ml.ru', '493 123 45 67', '652050, Кемеровская область, город Юрга, ул. Лесная, 15', '222987654321', 7),
(2, 'Паркет 29', 'Петров Василий Петрович', 'vppetrov@vl.ru', '987 123 56 78', '164500, Архангельская область, город Северодвинск, ул. Строителей, 18', '330987654321', 8);

-- Продукция
INSERT INTO Products (ProductTypeID, ProductName, Article, MinPriceForPartner) VALUES
(1, 'Паркетная доска Ясень темный однополосная 14 мм', '8858958', 4456.90),
(2, 'Инженерная доска Дуб Французская елка однополосная 12 мм', '7750282', 7330.99),
(3, 'Ламинат Дуб дымчато-белый 33 класс 12 мм', '7028748', 3890.41);

-- Продажи
INSERT INTO PartnerSales (PartnerID, ProductID, Quantity, UnitPrice, SaleDate) VALUES
(1, 1, 15500, 4456.90, '2023-03-23'),
(1, 3, 12350, 3890.41, '2023-12-18'),
(2, 2, 37400, 7330.99, '2023-06-07');

GO

-- ===================================================================
-- 6. ПОЛЕЗНЫЕ ПРЕДСТАВЛЕНИЯ (VIEWS) ДЛЯ УДОБСТВА
-- ===================================================================

-- Представление для удобного просмотра продаж
CREATE VIEW vw_PartnerSalesDetails AS
SELECT 
    ps.SaleID,
    p.PartnerName,
    pt.PartnerTypeName,
    pr.ProductName,
    pr.Article,
    prt.ProductTypeName,
    ps.Quantity,
    ps.UnitPrice,
    ps.TotalAmount,
    ps.SaleDate,
    p.Rating AS PartnerRating
FROM PartnerSales ps
    INNER JOIN Partners p ON ps.PartnerID = p.PartnerID
    INNER JOIN PartnerTypes pt ON p.PartnerTypeID = pt.PartnerTypeID
    INNER JOIN Products pr ON ps.ProductID = pr.ProductID
    INNER JOIN ProductTypes prt ON pr.ProductTypeID = prt.ProductTypeID
WHERE p.IsActive = 1 AND pr.IsActive = 1;

GO

-- Представление для анализа партнёров
CREATE VIEW vw_PartnerAnalytics AS
SELECT 
    p.PartnerID,
    p.PartnerName,
    pt.PartnerTypeName,
    p.Rating,
    COUNT(ps.SaleID) AS TotalSales,
    ISNULL(SUM(ps.TotalAmount), 0) AS TotalRevenue,
    ISNULL(AVG(ps.TotalAmount), 0) AS AvgSaleAmount,
    MAX(ps.SaleDate) AS LastSaleDate
FROM Partners p
    LEFT JOIN PartnerSales ps ON p.PartnerID = ps.PartnerID
    INNER JOIN PartnerTypes pt ON p.PartnerTypeID = pt.PartnerTypeID
WHERE p.IsActive = 1
GROUP BY p.PartnerID, p.PartnerName, pt.PartnerTypeName, p.Rating;

GO

PRINT 'База данных успешно создана в 3НФ!';
PRINT 'Структура соответствует принципам SOLID и готова к production использованию.'; 