   M S B A M L   `   `   `  ����C  ?FloorAPP, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null#clr-namespace:FloorAPPFloorAPP  5          FloorAPP.MainWindow   5      R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5      R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      (localclr-namespace:FloorAPP     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5        � Title$,  &Мастер пол - Партнеры��5      $
��1000��5	      $	��600��5
      $��Segoe UI)�5      .��5      � 
������� � RowDefinitions 5   
   �� 5      $��80 �6   �� 5      $��* �6   .+�5   
   � $��0��6   ���#F4E8D3.+�5      �� $��20q�5      $��Center=�5       �� Orientation$ 
Horizontal=�5      .+�5      �� $��0,0,15,0q�6   $��/Resource/MasterFloor.png��6*   �� 5      $��Center=�5      $��Center=�5      $��24(�5      $
��Bold"�5      
���   �$��Мастер пол��5!      5"      5#      � 5&   
   $��1��6   $��20q�6    5'      �� 5(      $��50 �6    �� 5)      $��* �6    .+�5-      �� $��0��6   $ 
Horizontal=�6&   .+�50      �� -   5        $��btnAdd��51      $��5q�52      $
��15,8q�53      ���#67BA80$��0q�55      $'��!Добавить партнера��57      
�������58      �� 5:      -   5        $��
btnRefresh��5;      $��5q�5<      $
��15,8q�5=      ���#67BA80$��0q�5?      $��Обновить��5A      
�������5B      �� 5C      -   5        $��
btnHistory��5D      $��5q�5E      $
��15,8q�5F      ���#67BA80$��0q�5H      $!��История продаж��5J      
�������5K      5L      &   System.Windows.Controls.DataGrid  5P      -   5        $��
dgPartners��5Q      $��1��5R         AutoGenerateColumns .     CanUserAddRows .     
IsReadOnly .    Columns 5W      0  *System.Windows.Controls.DataGridTextColumn  5X      ,  &System.Windows.Controls.DataGridColumn   Width5  /System.Windows.Controls.DataGridLengthConverter$	 200 5Y         Header$ Наименование��5[      1  +System.Windows.Controls.DataGridBoundColumn	   Binding	 5Z      �� *CompanyName+5[        5\      $	 100 5]      $ Тип��5_      	 5^      �� *
TypeName+5_        5`      $ 80 5a      $ Рейтинг��5c      	 5b      �� *Rating+5c        5d      $ 80 5e      $ Скидка %��5g      	 5f      �� *
Discount+5g        5h      $	 150 5i      $ Директор��5k      	 5j      �� *DirectorName+5k        5l      $	 120 5m      $ Телефон��5o      	 5n      �� *Phone+5o        5p      $	 150 5q      $ Email��5s      	 5r      �� *Email+5s      5u      5v      5w      5x      