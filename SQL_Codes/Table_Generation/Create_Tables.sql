--Table: Appearance  <--Appears--> Player_Character
Create Table Appearance(
Appearance_ID int PRIMARY KEY  not null,
Hair_Color NVARCHAR(30),
Eye_Color NVARCHAR(30),
Body_Type NVARCHAR(50),
);

--Table: Inventory  <--Have Acces To--> Player_Character
create Table Inventory(
Inventory_ID int PRIMARY KEY NOT NULL,
Capacity int not null,
Current_Amount int not null
);

--Table: Items
create Table Items(
Item_ID int PRIMARY KEY NOT NULL,
Item_Name NVARCHAR(255) NOT NULL,
Req_Level int NOT NULL,
Item_Stats int NOT NULL,
);

--Table : Items <-Contasins-> Inventory
create Table Contasins(
Inventory_ID int not null,
FOREIGN KEY (Inventory_ID) REFERENCES Inventory(Inventory_ID),
Item_ID int not null,
FOREIGN KEY (Item_ID) references Items(Item_ID),
PRIMARY KEY(Inventory_ID,Item_ID),
);

--TABLE: Attributes 
create Table Attributes(
Attribute_ID int PRIMARY KEY  not null,
MagicPower int not null,
Dexterity int not null,
Strength int not null,
Mana int not null,
Magic_Resistanse int not null,
Armor int not null,
Max_Health int not null,
);

--TABLE : FACTİONS

create Table Factions(
Faction_ID int PRIMARY KEY NOT NULL,
Donation int not null,
Faction_Name NVARCHAR(255) NOT NULL,
);

--TABLE:AUTHORİTY
Create Table Authority(
Authority_Type NVARCHAR(10) NOT NULL,
Authority_ID int not null,
PRIMARY KEY (Authority_Type,Authority_ID),
Can_Banish BIT NOT NULL,
Can_Kick BIT NOT NULL,
Can_Timeout BIT NOT NULL,
Can_Block BIT NOT NULL,
);

--TABLE:SERVER
create Table Server(
Server_ID int  NOT NULL,
Server_IP int Not NULL,
PRIMARY KEY(Server_ID,Server_IP),
Server_Location NVARCHAR(255) NOT NULL,
);


--TABLE:Membership_Account
create Table Membership_Account(
Account_ID int PRIMARY KEY NOT NULL,
User_Name NVARCHAR(255) NOT NULL,
Password NVARCHAR(255) NOT NULL,
email_Address NVARCHAR(255) NOT NULL,

Authority_Type NVARCHAR(10) not null,
Authority_ID int not null,
FOREIGN KEY(Authority_Type,Authority_ID) REFERENCES Authority(Authority_Type,Authority_ID),

Server_ID int  NOT NULL,
Server_IP int Not NULL,
FOREIGN KEY (Server_ID,Server_IP) REFERENCES Server(Server_ID,Server_IP),

);

CREATE TABLE Friends_with (
    account_id_1 INT,
    account_id_2 INT,
    PRIMARY KEY (account_id_1, account_id_2),
    FOREIGN KEY (account_id_1) REFERENCES membership_account(Account_ID),
    FOREIGN KEY (account_id_2) REFERENCES membership_account(Account_ID),
    CHECK (account_id_1 != account_id_2)  -- Prevents self-friendship
);

-- Main TABLE: Player_Character
Create Table Player_Character(
 Character_ID int PRIMARY KEY Not null,
 Character_Name NVARCHAR(255) NOT NULL,
 Character_Level int Not Null,
 Character_XP int not null,
 Character_Req_XP int not null,

 Appearance_ID int not null,
 FOREIGN KEY (Appearance_ID) REFERENCES Appearance(Appearance_ID),
 Inventory_ID int not null,
 FOREIGN KEY (Inventory_ID) REFERENCES Inventory(Inventory_ID),
 Attribute_ID int not null,
 FOREIGN KEY (Attribute_ID) REFERENCES Attributes(Attribute_ID),
 Faction_ID int not null,
 FOREIGN KEY (Faction_ID) REFERENCES Factions(Faction_ID),
 Account_ID int not null,
 FOREIGN KEY (Account_ID) REFERENCES Membership_Account(Account_ID),
);

-- Table: Proficiency
Create Table Proficiency(
Proficiency_ID int PRIMARY KEY NOT NULL,
Magic_Level int Not null,
Melee_Level int Not null,
Ranged_Level int Not null,
Blocking_Level int Not null
);

--Table: Player_Character <---Learns---> Proficiency
Create Table Learns(
Character_ID int not null,
FOREIGN KEY(Character_ID) REFERENCES Player_Character(Character_ID),
Proficiency_ID int not null,
FOREIGN KEY(Proficiency_ID) REFERENCES Proficiency(Proficiency_ID),
PRIMARY KEY(Character_ID,Proficiency_ID)
);

--Table : NPC
create Table NPC(
NPC_ID int PRIMARY KEY NOT NULL,
NPC_Name NVARCHAR(255) not null,

Attribute_ID int not null,
FOREIGN KEY(Attribute_ID) REFERENCES Attributes(Attribute_ID),
);

--Table: Quests
create Table Quests(
Quest_ID int PRIMARY KEY NOT NULL,
Description NVARCHAR(255) not null,
Reward_Amount int not null,
Quest_Name NVARCHAR(255) NOT NULL,

NPC_ID int not null,
FOREIGN KEY (NPC_ID) REFERENCES NPC(NPC_ID),
);

--Table: Player_Character <-WİLL FOLLOW-> Quests
create Table WİLL_FOLLOW(
Character_ID int not null,
FOREIGN KEY (Character_ID) references Player_Character(Character_ID),
Quest_ID int NOT NULL,
FOREIGN KEY (Quest_ID) REFERENCES Quests(Quest_ID),
PRIMARY KEY (Character_ID,Quest_ID),
isActive BIT not null,
);

--Table : Monsters
create Table Monsters(
Monster_ID int PRIMARY KEY NOT NULL,
Monster_Reward int not null,

Attribute_ID int not null,
FOREIGN KEY(Attribute_ID) REFERENCES Attributes(Attribute_ID),
);

--TABLE : Skills 

create Table Skills(
Skills_ID int PRIMARY KEY NOT NULL,
Skill_Cost int not null,
Skill_Range int not null,
);

--Table : Skills <--CAN USE--> Player_Character
create Table CanUse(
Skills_ID int not null,
FOREIGN KEY (Skills_ID) REFERENCES Skills(Skills_ID),
Character_ID int not null,
FOREIGN KEY (Character_ID) REFERENCES Player_Character(Character_ID),
Req_Prof_Level int,
PRIMARY KEY(Character_ID,Skills_ID),
);

--TABLE:ACHİVEMENTS

create Table Achivements(
Achivement_ID int PRIMARY KEY NOT NULL,
Achivement_Description NVARCHAR(255) NOT NULL,
Achivement_Reward int not null,
Achivement_Req int not null,
);

--Table: Achivements <--Achives--> Membership_Account

create Table Achives(
Achivement_ID int NOT NULL,
FOREIGN KEY(Achivement_ID) REFERENCES Achivements(Achivement_ID),
Account_ID int not null,
FOREIGN KEY(Account_ID) REFERENCES Membership_Account(Account_ID),
PRIMARY KEY (Achivement_ID,Account_ID),
);
