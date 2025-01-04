CREATE PROCEDURE CompleteQuestAndAwardXP
    @CharacterID INT,
    @QuestID INT
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        
        DECLARE @CurrentXP INT, @RequiredXP INT, @Level INT, @RewardXP INT;
        DECLARE @AttributeID INT;

        --G�rev �d�l�n� �ek
        SELECT Reward_Amount
        INTO @RewardXP
        FROM Quests
        WHERE Quest_ID = @QuestID;

        IF @RewardXP IS NULL
        BEGIN
            PRINT 'G�rev bulunamad�';
        END

        -- Karakter bilgilerini �ek
        SELECT Character_XP, Character_Req_XP, Character_Level, Attribute_ID
        INTO @CurrentXP, @RequiredXP, @Level, @AttributeID
        FROM Player_Character
        WHERE Character_ID = @CharacterID;

        IF @CurrentXP IS NULL
        BEGIN
            PRINT 'Karakter bulunamad�';
        END

        -- Karakter XP sini g�ncelle
        SET @CurrentXP = @CurrentXP + @RewardXP;

        -- Level atlad� m�?
        WHILE @CurrentXP >= @RequiredXP
        BEGIN
            SET @CurrentXP = @CurrentXP - @RequiredXP; -- XP'yi gerekli miktar kadar azalt
            SET @Level = @Level + 1;                  -- level art���
            SET @RequiredXP = @RequiredXP + (@RequiredXP / 2); -- Gereken XP yi 1.5 kat�na ��kar

            -- �d�l olarak nitelikleri g�ncelle
            UPDATE Attributes
            SET 
                Max_Health = Max_Health + 10,
                Strength = Strength + 2,
                MagicPower = MagicPower + 2,
                Armor = Armor + 1
            WHERE Attribute_ID = @AttributeID;
        END

        -- Karakter bilgilerini g�ncelle
        UPDATE Player_Character
        SET 
            Character_XP = @CurrentXP,
            Character_Level = @Level,
            Character_Req_XP = @RequiredXP
        WHERE Character_ID = @CharacterID;

        -- g�revi tamamlanm�� olarak i�aretle
        UPDATE W�LL_FOLLOW
        SET isActive = 0
        WHERE Character_ID = @CharacterID AND Quest_ID = @QuestID;

        -- Her �ey ba�ar�l� ise de�i�iklikleri ger�ekle�tir
        COMMIT TRANSACTION;

        PRINT 'XP ba�ar�yla g�ncellendi';
    CATCH
    BEGIN CATCH
        -- Hata olursa eski durumuna d�n
        ROLLBACK TRANSACTION;

        PRINT '�d�l� verirken bir sorun ile kar��la��ld�';

    END CATCH
END;
