   M S B A M L   `   `   `  ����  FloorAPP#    FloorAPP.PartnerHistoryWindow   5      R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5      R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5        � Title$!  История продаж��5      $	��800��5      $	��500��5      $��Segoe UI)�5      .��5
      � 
������� � RowDefinitions 5   
   �� 5      $��80 �6   �� 5      $��* �6   �� 5      $��60 �6   .+�5   
   � $��0��6   ���#F4E8D3.+�5      �� -   5        $��txtTitle��5      $��20q�5      $��Center=�5      $��18(�5      $
��Bold"�5      $2��,История продаж партнера��5      5      &   System.Windows.Controls.DataGrid  5   
   -   5        $��	dgHistory��5      $��1��5      $��20q�5          AutoGenerateColumns .     CanUserAddRows .     
IsReadOnly .    Columns 5$      0  *System.Windows.Controls.DataGridTextColumn  5%      ,  &System.Windows.Controls.DataGridColumn   Width5  /System.Windows.Controls.DataGridLengthConverter$	 300 5&         Header$1 +Наименование продукции��5(      1  +System.Windows.Controls.DataGridBoundColumn   Binding 5'      �� *Products.ProductName+5(        5)      $	 100 5*      $ Количество��5,       5+      �� *
Quantity+5,        5-      $	 120 5.      $ Дата продажи��50       5/      �� *
SaleDate+	 �� StringFormat$	 
dd.MM.yyyy��50      52      �� 55   
   -   5        $��btnClose��56      $��2��57      $	��100��58      $��35��59      $��20q�5:      $��Right=�5;      ���#67BA80$��0q�5=      $��Закрыть��5?      
�������5@      5A      5B      