CREATE PROCEDURE UnlockSkillForCharacter
    @CharacterID INT,
    @SkillID INT
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY

        DECLARE @ProficiencyID INT, @CurrentProficiencyLevel INT, @RequiredProficiencyLevel INT;

        -- skill i�in gereken levli �ek
        SELECT Req_Prof_Level
        INTO @RequiredProficiencyLevel
        FROM Skills
        WHERE Skills_ID = @SkillID;

        IF @RequiredProficiencyLevel IS NULL
        BEGIN
            PRINT 'B�yle bir skill yok';
        END

        -- Karakterin Ustal�k seviyesini �ek
        SELECT Learns.Proficiency_ID, Proficiency.Magic_Level
        INTO @ProficiencyID, @CurrentProficiencyLevel
        FROM Learns
        INNER JOIN Proficiency ON Learns.Proficiency_ID = Proficiency.Proficiency_ID
        WHERE Learns.Character_ID = @CharacterID;

        IF @CurrentProficiencyLevel IS NULL
        BEGIN
            PRINT 'Karakter gereken bilgilere sahip de�il';
        END

        -- Karakter gereklilikleri kar��l�yor mu?
        IF @CurrentProficiencyLevel < @RequiredProficiencyLevel
        BEGIN
            PRINT 'Karakter gereken yeterlilik seviyesini kar��lam�yor';
        END

        -- skill hali haz�rda a��k m�
        IF EXISTS (SELECT 1 FROM CanUse WHERE Character_ID = @CharacterID AND Skills_ID = @SkillID)
        BEGIN
            PRINT 'Bu skill hali haz�rda bu karakter i�in a��k';
        END

        -- skillin kilidini a�
		INSERT INTO CanUse (Skills_ID, Character_ID, Req_Prof_Level)
        VALUES (@SkillID, @CharacterID, @RequiredProficiencyLevel);

        -- De�i�iklikleri ger�ekle�tir
        COMMIT TRANSACTION;

        PRINT 'Skill ba�ar�yla a��ld�';
    CATCH
    BEGIN CATCH
        -- Hata olursa eski durumuna d�n
        ROLLBACK TRANSACTION;

    END CATCH
END;
