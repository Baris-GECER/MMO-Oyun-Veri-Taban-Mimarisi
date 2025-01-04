CREATE PROCEDURE RemoveItemFromInventory
    @InventoryID INT,
    @ItemID INT,
    @QuantityToRemove INT
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        
		DECLARE @CurrentAmount INT;

        -- Item envanterde var m�?
        SELECT Current_Amount
        INTO @CurrentAmount
        FROM Contasins
        WHERE Inventory_ID = @InventoryID AND Item_ID = @ItemID;

        IF @CurrentAmount IS NULL
        BEGIN
            PRINT 'Item envanterde bulunamad�';
        END

        -- Kald�rmak i�in yeterli say�da item var m�?
        IF @QuantityToRemove > @CurrentAmount
        BEGIN
            PRINT '��karmak i�in gereken say�da e�ya yok';
        END

        -- Envanterden E�ya kald�r veya g�ncelle
        IF @QuantityToRemove = @CurrentAmount
        BEGIN
            -- e�ya say�s� kald�r�lacak ile ayn� ise e�yay� envanterden kald�r
            DELETE FROM Contasins
            WHERE Inventory_ID = @InventoryID AND Item_ID = @ItemID;
        END
        ELSE
        BEGIN
            -- Item say�s�n� azalt
            UPDATE Contasins
            SET Current_Amount = @CurrentAmount - @QuantityToRemove
            WHERE Inventory_ID = @InventoryID AND Item_ID = @ItemID;
        END

        -- Mevcut miktar� g�ncelle
        UPDATE Inventory
        SET Current_Amount = Current_Amount - @QuantityToRemove
        WHERE Inventory_ID = @InventoryID;

        -- Aktar�m� ger�ekle�tir
        COMMIT TRANSACTION;

        PRINT 'Item ba�ar�yla envanterden kald�r�ld�';
    CATCH
    BEGIN CATCH
        -- Hata olduysa eski haline geri getir
        ROLLBACK TRANSACTION;
		
		PRINT 'Itemi envanterden kald�r�rken bir hatayla kar��la��ld�';
    
	END CATCH
END;
