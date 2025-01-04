CREATE PROCEDURE LevelUpCharacter
    @CharacterID INT
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        
        DECLARE @CurrentXP INT, @RequiredXP INT, @Level INT;
        DECLARE @AttributeID INT;
		
        -- Karakter verilerini al
        SELECT Character_XP, Character_Req_XP, Character_Level, Attribute_ID
        INTO @CurrentXP, @RequiredXP, @Level, @AttributeID
        FROM Player_Character
        WHERE Character_ID = @CharacterID;

		if @CurrentXP < @RequiredXP
        BEGIN
            PRINT 'Character does not have enough XP to level up.';
        END;

		else
		BEGIN
        -- Level atladý mý?
			WHILE @CurrentXP >= @RequiredXP
			BEGIN
				@LevelUpAmount = @LevelUpAmount + 1;
				SET @CurrentXP = @CurrentXP - @RequiredXP; -- XP'yi gerekli miktar kadar azalt
				SET @Level = @Level + 1;                  -- level artýþý
				SET @RequiredXP = @RequiredXP + (@RequiredXP / 2); -- Gereken XP yi 1.5 katýna çýkar

				-- ödül olarak nitelikleri güncelle
				UPDATE Attributes
				SET 
			        Max_Health = Max_Health + 10),
		            Strength = Strength + 2,
	                MagicPower = MagicPower + 2,
					Armor = Armor + 1
				WHERE Attribute_ID = @AttributeID;
				END
		END
        -- Karakter bilgilerini güncelle
        UPDATE Player_Character
        SET 
            Character_XP = @CurrentXP,
            Character_Level = @Level,
            Character_Req_XP = @RequiredXP
        WHERE Character_ID = @CharacterID;

   -- Enhance attributes as a reward for leveling up
            UPDATE Attributes
			
            SET 
                Max_Health = Max_Health + 100,
                MagicPower = Magic_Resistanse + 2,
				Dexterity = Dexterity + 2,
				Strength = Strength + 2,
				mana = mana + 10
                
			WHERE Attribute_ID = @AttributeID;

            PRINT 'Karakter baþarýyla seviye atladý';
       
        -- Commit the transaction if all operations succeed
        COMMIT TRANSACTION;

    CATCH

    BEGIN CATCH
        -- Rollback the transaction in case of any errors
        ROLLBACK TRANSACTION;
        PRINT 'seviye atlarken bir hata gerçekleþti';

    END CATCH
END;
