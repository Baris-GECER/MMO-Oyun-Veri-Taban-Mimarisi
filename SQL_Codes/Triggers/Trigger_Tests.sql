-- 1. Appearance tablosuna yeni bir kayıt ekleyelim ve güncelleme yaparak `trg_AfterAppearanceUpdate` tetikleyicisini tetikleyelim
INSERT INTO Appearance (Appearance_ID, Hair_Color, Eye_Color, Body_Type)
VALUES (1, 'Brown', 'Green', 'Slim');

UPDATE Appearance
SET Hair_Color = 'Black', Eye_Color = 'Blue', Body_Type = 'Athletic'
WHERE Appearance_ID = 1;

-- Appearance_Change_Log tablosunu kontrol edelim
SELECT * FROM Appearance_Change_Log WHERE Appearance_ID = 1;

-- 2. Inventory ve Items tablolarına yeni kayıtlar ekleyelim
INSERT INTO Inventory (Inventory_ID, Capacity, Current_Amount)
VALUES (1, 10, 5);

INSERT INTO Items (Item_ID, Item_Name, Req_Level, Item_Stats)
VALUES (100, 'Magic Sword', 1, 10);

-- Contasins tablosuna yeni bir kayıt ekleyelim ve `trg_UpdateInventory` tetikleyicisini tetikleyelim
INSERT INTO Contasins (Inventory_ID, Item_ID)
VALUES (1, 100);

-- Inventory tablosundaki Current_Amount değerini kontrol edelim
SELECT Inventory_ID, Capacity, Current_Amount 
FROM Inventory 
WHERE Inventory_ID = 1;

-- 3. Contasins tablosundan bir kayıt silelim ve `trg_UpdateInventoryOnDelete` tetikleyicisini tetikleyelim
DELETE FROM Contasins
WHERE Inventory_ID = 1 AND Item_ID = 100;

-- Inventory tablosundaki Current_Amount değerini tekrar kontrol edelim
SELECT Inventory_ID, Capacity, Current_Amount 
FROM Inventory 
WHERE Inventory_ID = 1;
