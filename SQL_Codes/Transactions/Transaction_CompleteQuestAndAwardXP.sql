CREATE PROCEDURE CompleteQuestAndAwardXP
    @CharacterID INT,
    @QuestID INT
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        
        DECLARE @CurrentXP INT, @RequiredXP INT, @Level INT, @RewardXP INT;
        DECLARE @AttributeID INT;

        --Görev ödülünü çek
        SELECT Reward_Amount
        INTO @RewardXP
        FROM Quests
        WHERE Quest_ID = @QuestID;

        IF @RewardXP IS NULL
        BEGIN
            PRINT 'Görev bulunamadý';
        END

        -- Karakter bilgilerini çek
        SELECT Character_XP, Character_Req_XP, Character_Level, Attribute_ID
        INTO @CurrentXP, @RequiredXP, @Level, @AttributeID
        FROM Player_Character
        WHERE Character_ID = @CharacterID;

        IF @CurrentXP IS NULL
        BEGIN
            PRINT 'Karakter bulunamadý';
        END

        -- Karakter XP sini güncelle
        SET @CurrentXP = @CurrentXP + @RewardXP;

        -- Level atladý mý?
        WHILE @CurrentXP >= @RequiredXP
        BEGIN
            SET @CurrentXP = @CurrentXP - @RequiredXP; -- XP'yi gerekli miktar kadar azalt
            SET @Level = @Level + 1;                  -- level artýþý
            SET @RequiredXP = @RequiredXP + (@RequiredXP / 2); -- Gereken XP yi 1.5 katýna çýkar

            -- ödül olarak nitelikleri güncelle
            UPDATE Attributes
            SET 
                Max_Health = Max_Health + 10,
                Strength = Strength + 2,
                MagicPower = MagicPower + 2,
                Armor = Armor + 1
            WHERE Attribute_ID = @AttributeID;
        END

        -- Karakter bilgilerini güncelle
        UPDATE Player_Character
        SET 
            Character_XP = @CurrentXP,
            Character_Level = @Level,
            Character_Req_XP = @RequiredXP
        WHERE Character_ID = @CharacterID;

        -- görevi tamamlanmýþ olarak iþaretle
        UPDATE WÝLL_FOLLOW
        SET isActive = 0
        WHERE Character_ID = @CharacterID AND Quest_ID = @QuestID;

        -- Her þey baþarýlý ise deðiþiklikleri gerçekleþtir
        COMMIT TRANSACTION;

        PRINT 'XP baþarýyla güncellendi';
    CATCH
    BEGIN CATCH
        -- Hata olursa eski durumuna dön
        ROLLBACK TRANSACTION;

        PRINT 'Ödülü verirken bir sorun ile karþýlaþýldý';

    END CATCH
END;
