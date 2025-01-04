CREATE PROCEDURE UnlockSkillForCharacter
    @CharacterID INT,
    @SkillID INT
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY

        DECLARE @ProficiencyID INT, @CurrentProficiencyLevel INT, @RequiredProficiencyLevel INT;

        -- skill için gereken levli çek
        SELECT Req_Prof_Level
        INTO @RequiredProficiencyLevel
        FROM Skills
        WHERE Skills_ID = @SkillID;

        IF @RequiredProficiencyLevel IS NULL
        BEGIN
            PRINT 'Böyle bir skill yok';
        END

        -- Karakterin Ustalýk seviyesini çek
        SELECT Learns.Proficiency_ID, Proficiency.Magic_Level
        INTO @ProficiencyID, @CurrentProficiencyLevel
        FROM Learns
        INNER JOIN Proficiency ON Learns.Proficiency_ID = Proficiency.Proficiency_ID
        WHERE Learns.Character_ID = @CharacterID;

        IF @CurrentProficiencyLevel IS NULL
        BEGIN
            PRINT 'Karakter gereken bilgilere sahip deðil';
        END

        -- Karakter gereklilikleri karþýlýyor mu?
        IF @CurrentProficiencyLevel < @RequiredProficiencyLevel
        BEGIN
            PRINT 'Karakter gereken yeterlilik seviyesini karþýlamýyor';
        END

        -- skill hali hazýrda açýk mý
        IF EXISTS (SELECT 1 FROM CanUse WHERE Character_ID = @CharacterID AND Skills_ID = @SkillID)
        BEGIN
            PRINT 'Bu skill hali hazýrda bu karakter için açýk';
        END

        -- skillin kilidini aç
		INSERT INTO CanUse (Skills_ID, Character_ID, Req_Prof_Level)
        VALUES (@SkillID, @CharacterID, @RequiredProficiencyLevel);

        -- Deðiþiklikleri gerçekleþtir
        COMMIT TRANSACTION;

        PRINT 'Skill baþarýyla açýldý';
    CATCH
    BEGIN CATCH
        -- Hata olursa eski durumuna dön
        ROLLBACK TRANSACTION;

    END CATCH
END;
