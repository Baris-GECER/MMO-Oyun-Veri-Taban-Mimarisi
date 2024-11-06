-- Player_Account Table
CREATE TABLE Player_Account (
    AccountID INT PRIMARY KEY,
    Username VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE,
    Password VARCHAR(255) NOT NULL,
);

-- Player_Character Table (Child of Player_Account)
CREATE TABLE Player_Character (
    CharacterID INT PRIMARY KEY,
    AccountID INT,
    CharacterName VARCHAR(255),
    CharacterLevel INT,
    CharacterEXP INT,
	CharacterReqXp INT,
    FOREIGN KEY (AccountID) REFERENCES Player_Account(AccountID)
);

-- Friends Relationship Table (Self-referencing Player_Account for friendships)
CREATE TABLE Friends (
    AccountID1 INT,
    AccountID2 INT,
    FriendshipDate DATE,
    PRIMARY KEY (AccountID1, AccountID2),
    FOREIGN KEY (AccountID1) REFERENCES Player_Account(AccountID),
    FOREIGN KEY (AccountID2) REFERENCES Player_Account(AccountID)
);

-- NPCs Table (Non-player characters with various roles)
CREATE TABLE NPCs (
    NPC_ID INT PRIMARY KEY,
    NPC_Name VARCHAR(255),
);

-- Monsters Table (Monsters in the game with specific attributes)
CREATE TABLE Monsters (
    MonsterID INT PRIMARY KEY,
    MonsterName VARCHAR(255),
	Reward INT,
	RequiredEnvironment varchar(64)
);

-- Attributes Table (Attributes related to Player_Character, Monsters, and NPCs)
CREATE TABLE Attributes (
    AttributeID INT PRIMARY KEY,
    MaxHealth INT,
	Health INT,
	Armor INT,
	MagicResistance INT,
	Mana INT,
	Strength INT,
    Dexterity INT,
    MagicPower INT,
    Stamina INT,
    CharacterID INT,
    MonsterID INT,
    NPC_ID INT,
    FOREIGN KEY (CharacterID) REFERENCES Player_Character(CharacterID),
    FOREIGN KEY (MonsterID) REFERENCES Monsters(MonsterID),
    FOREIGN KEY (NPC_ID) REFERENCES NPCs(NPC_ID)
);

-- Factions Table (Each faction has members via Faction_Memberships)
CREATE TABLE Factions (
    FactionID INT PRIMARY KEY,
    FactionName VARCHAR(50),
    Description TEXT
);

-- Faction_Memberships Table (Many-to-Many relationship between Player_Character and Factions)
CREATE TABLE Faction_Memberships (
    CharacterID INT,
    FactionID INT,
    DonationAmount INT,
    PRIMARY KEY (CharacterID, FactionID),
    FOREIGN KEY (CharacterID) REFERENCES Player_Character(CharacterID),
    FOREIGN KEY (FactionID) REFERENCES Factions(FactionID)
);

-- Skills Table (Skills can be associated with different entities)
CREATE TABLE Skills (
    SkillID INT PRIMARY KEY,
	SkillCost INT,
	SkillRange INT,
    SkillName VARCHAR(50),
    SkillReqProfLevel INT,
);

-- Player_Skills Table (Associates Player_Character with Skills they possess)
CREATE TABLE Player_Skills (
    CharacterID INT,
    SkillID INT,
    PRIMARY KEY (CharacterID, SkillID),
    FOREIGN KEY (CharacterID) REFERENCES Player_Character(CharacterID),
    FOREIGN KEY (SkillID) REFERENCES Skills(SkillID)
);

-- Achievements Table (Each achievement belongs to a Player_Account)
CREATE TABLE Achievements (
    AchievementID INT PRIMARY KEY,
    AchievementName VARCHAR(255),
    AchivementDescription varchar(255),
    AccountID INT,
    FOREIGN KEY (AccountID) REFERENCES Player_Account(AccountID)
);

-- Proficiency Table (Proficiency levels specific to Player_Character)
CREATE TABLE Proficiency (
    ProficiencyID INT PRIMARY KEY,
    CharacterID INT,
    MagicLevel INT,
    WeleeLevel INT,
	RangedLevel INT,
	BlockingLevel INT,
    FOREIGN KEY (CharacterID) REFERENCES Player_Character(CharacterID)
);

-- Appearance Table (Appearance details for Player_Character)
CREATE TABLE Appearance (
    AppearanceID INT PRIMARY KEY,
    CharacterID INT,
    EyeColor VARCHAR(50),
    HairColor VARCHAR(50),
    BodyType varchar(12),
    MuscleMass FLOAT,
    FOREIGN KEY (CharacterID) REFERENCES Player_Character(CharacterID)
);

-- Inventory Table (Each inventory is tied to a specific Player_Character)
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY,
    CharacterID INT,
    FOREIGN KEY (CharacterID) REFERENCES Player_Character(CharacterID)
);

-- Items Table (Items can be stored in Inventory)
CREATE TABLE Items (
    ItemID INT PRIMARY KEY,
    ItemName VARCHAR(255),
	ItemReqLevel INT,
	ItemStats INT,
);

-- Inventory_Items Table (Many-to-Many relationship between Inventory and Items)
CREATE TABLE Inventory_Items (
    InventoryID INT,
    ItemID INT,
    Quantity INT,
    PRIMARY KEY (InventoryID, ItemID),
    FOREIGN KEY (InventoryID) REFERENCES Inventory(InventoryID),
    FOREIGN KEY (ItemID) REFERENCES Items(ItemID)
);

-- Quests Table (Quests can be assigned to characters)
CREATE TABLE Quests (
    QuestID INT PRIMARY KEY,
    QuestName VARCHAR(255),
	QuestReward INT,
    QuestDescription TEXT,
	OsActive BIT,
);

-- Quest_Assignments Table (Many-to-Many relationship between Player_Character and Quests)
CREATE TABLE Quest_Assignments (
    CharacterID INT,
    QuestID INT,
    PRIMARY KEY (CharacterID, QuestID),
    FOREIGN KEY (CharacterID) REFERENCES Player_Character(CharacterID),
    FOREIGN KEY (QuestID) REFERENCES Quests(QuestID)
);


-- Quest_Monsters Table (Associates Monsters with Quests they are related to)
CREATE TABLE Quest_Monsters (
    QuestID INT,
    MonsterID INT,
    PRIMARY KEY (QuestID, MonsterID),
    FOREIGN KEY (QuestID) REFERENCES Quests(QuestID),
    FOREIGN KEY (MonsterID) REFERENCES Monsters(MonsterID)
);

-- Quest_NPCs Table (Associates NPCs with Quests they are related to)
CREATE TABLE Quest_NPCs (
    QuestID INT,
    NPC_ID INT,
    PRIMARY KEY (QuestID, NPC_ID),
    FOREIGN KEY (QuestID) REFERENCES Quests(QuestID),
    FOREIGN KEY (NPC_ID) REFERENCES NPCs(NPC_ID)
);
