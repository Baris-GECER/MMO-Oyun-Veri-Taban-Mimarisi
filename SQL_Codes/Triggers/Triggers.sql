---TRİGGER -------
---ESKİ VE YENİ VERİLERİ TUTMAK İÇİN TABLO AÇIYORUZZ
CREATE TABLE Appearance_Change_Log (
    Log_ID INT PRIMARY KEY IDENTITY(1,1),
    Old_Hair_Color NVARCHAR(30),
    New_Hair_Color NVARCHAR(30),
    Old_Eye_Color NVARCHAR(30),
    New_Eye_Color NVARCHAR(30),
    Old_Body_Type NVARCHAR(50),
    New_Body_Type NVARCHAR(50),
    Change_Date DATETIME DEFAULT GETDATE(),
    Appearance_ID INT
);

GO
CREATE TRIGGER trg_AfterAppearanceUpdate
ON Appearance
AFTER UPDATE
AS
BEGIN
    -- Eski ve yeni verileri almak için tablo bazlı işlemler
    SELECT 
        d.Appearance_ID AS [Appearance ID],
        d.Hair_Color AS [Old Hair Color],
        i.Hair_Color AS [New Hair Color],
        d.Eye_Color AS [Old Eye Color],
        i.Eye_Color AS [New Eye Color],
        d.Body_Type AS [Old Body Type],
        i.Body_Type AS [New Body Type]
    FROM 
        DELETED d
    INNER JOIN 
        INSERTED i ON d.Appearance_ID = i.Appearance_ID;

    -- Mesaj yazdır
    PRINT 'Update işlemi tamamlandı. Değişiklikler yukarıda listelenmiştir.';
END;
GO

go
CREATE TRIGGER trg_UpdateInventory
ON Contains_
AFTER INSERT
AS
BEGIN
    DECLARE @Inventory_ID INT;
    DECLARE @Current_Amount INT;
    DECLARE @Capacity INT;

    -- İlgili Inventory_ID'yi al
    SELECT @Inventory_ID = inserted.Inventory_ID
    FROM inserted;

    -- Mevcut Current_Amount ve Capacity değerlerini al
    SELECT @Current_Amount = Inventory.Current_Amount,
           @Capacity = Inventory.Capacity
    FROM Inventory
    WHERE Inventory.Inventory_ID = @Inventory_ID;

    -- Capacity'yi aşmamak şartıyla Current_Amount'u arttır
    IF @Current_Amount + 1 <= @Capacity
    BEGIN
        UPDATE Inventory
        SET Current_Amount = @Current_Amount + 1
        WHERE Inventory.Inventory_ID = @Inventory_ID;
    END
    ELSE
    BEGIN
        RAISERROR('Envanter kapasitesi aşıldı.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
go

go
ALTER TRIGGER trg_UpdateInventoryOnDelete
ON Contains_
AFTER DELETE
AS
BEGIN
    DECLARE @Item_ID INT;
    DECLARE @Current_Amount INT;

    -- İlgili Inventory_ID'yi al
    SELECT @Item_ID = deleted.Item_ID
    FROM deleted;

    -- Mevcut Current_Amount değerini al
	declare @envID int
    SELECT @envID = Inventory_ID
    FROM Contains_
    WHERE Contains_.Item_ID = @Item_ID;

	SELECT @Current_Amount = Current_Amount
	from Inventory
	where Inventory_ID = @envID

    -- Current_Amount'u 0'dan küçük olmamak şartıyla azalt
    IF @Current_Amount - 1 >= 0
    BEGIN
        UPDATE Inventory
        SET Current_Amount = @Current_Amount - 1
        WHERE Inventory.Inventory_ID = @Item_ID;
    END
    ELSE
    BEGIN
        RAISERROR('Envanterdeki eşya sayısı negatif olamaz', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;

go
