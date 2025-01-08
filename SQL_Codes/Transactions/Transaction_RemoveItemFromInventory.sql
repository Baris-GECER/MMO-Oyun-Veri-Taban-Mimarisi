CREATE PROCEDURE RemoveItemFromInventory
    @InventoryID INT,
    @ItemID INT,
    @QuantityToRemove INT
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        
		DECLARE @CurrentAmount INT;

        -- Item envanterde var mý?
        SELECT @CurrentAmount = Current_Amount
        FROM Inventory
        WHERE Inventory_ID = @InventoryID;

        IF @CurrentAmount IS NULL
        BEGIN
            PRINT 'Item envanterde bulunamadı';
        END

        -- Kaldýrmak için yeterli sayýda item var mý?
        IF @QuantityToRemove > @CurrentAmount
        BEGIN
            PRINT 'Çıkarmak için gereken sayýda eşya yok';
        END

        -- Envanterden Eþya kaldýr veya güncelle
        IF @QuantityToRemove = @CurrentAmount
        BEGIN
            -- eþya sayýsý kaldýrýlacak ile ayný ise eþyayý envanterden kaldýr
            DELETE FROM Contains_
            WHERE Inventory_ID = @InventoryID AND Item_ID = @ItemID;
        END
        ELSE
        BEGIN
            -- Item sayýsýný azalt
            UPDATE Inventory
            SET Current_Amount = @CurrentAmount - @QuantityToRemove
            WHERE Inventory_ID = @InventoryID ;
        END

        -- Mevcut miktarý güncelle
        UPDATE Inventory
        SET Current_Amount = Current_Amount - @QuantityToRemove
        WHERE Inventory_ID = @InventoryID;

        -- Aktarýmý gerçekleþtir
        COMMIT TRANSACTION;

        PRINT 'Item başarıyla envanterden kaldırıldı';
    END TRY
    BEGIN CATCH
        -- Hata olduysa eski haline geri getir
        ROLLBACK TRANSACTION;
		
		PRINT 'Itemi envanterden kaldırırken bir hatayla karşılaşıldı';
    
	END CATCH
END;
