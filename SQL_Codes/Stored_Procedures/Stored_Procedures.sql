create procedure Bolumdekiler
@descriptionn varchar(50),
@aktif BIT 
AS 
Begin 
select*from Quests where  Description=@descriptionn and isActive=@aktif;
End;






CREATE PROCEDURE EnvanterBul3
    @id VARCHAR(10)
AS
BEGIN
    
    SELECT C.Item_ID, I.Item_Name,Req_Level,Item_Stats
    FROM Contasins C
    INNER JOIN Items I ON C.Item_ID = I.Item_ID
    WHERE C.Inventory_ID = @id;
END;





CREATE PROCEDURE Kisi
    @lwl1 INT,
    @lwl2 INT
AS
BEGIN
    SELECT 
	       pc.Character_ID,
		   pc.Character_Name,
	       p.Proficiency_ID,
           p.Magic_Level,
           p.Melee_Level,
           p.Ranged_Level,
           p.Blocking_Level
    FROM Learns l
    INNER JOIN Proficiency p ON l.Proficiency_ID = p.Proficiency_ID
    INNER JOIN Player_Character pc ON l.Character_ID = pc.Character_ID
	where pc.Character_Level between @lwl1 and @lwl2
	End;








CREATE PROCEDURE KlanUye
    @Klan_id INT -- Aranacak klan ID'si
AS
BEGIN
    DECLARE @PlayerCount INT;

   
    SELECT @PlayerCount = COUNT(*)
    FROM Player_Character
    WHERE Faction_ID = @Klan_id;

   
    RETURN @PlayerCount;
END;







create procedure UyeBilgi
@klanismi varchar(25)
as
begin 
select f.Faction_ID,f.Faction_Name,f.Donation,p.Account_ID,p.Character_Name,p.Character_Level,p.Appearance_ID,p.Attribute_ID,
p.Character_ID
from  Factions f inner join Player_Character p on f.Faction_ID=p.Faction_ID
where f.Faction_Name=@klanismi;
End
