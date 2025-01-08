
-----------------------------------------------------------------

insert into Achivements(Achivement_ID,Achivement_Description,Achivement_Reward,Achivement_Req)
values (1,'Play for the first time',1455,1300)
insert into Achivements values(2,'defeat a monster',1275,481)
insert into Achivements values(3,'complete a quest',1320,1100)
insert into Achivements values(4,'Level up for the first time',1469,890)
insert into Achivements values(5,'use a skill 100 times',1890,440)
insert into Achivements values(6,'defat a moster without other noticing',2100,560)
insert into Achivements values(7,'Demolish bandit hideout',2300,570)



-----------------------------------------------------------------
insert into Appearance(Appearance_ID,Hair_Color,Eye_Color,Body_Type)
values(16,'Brown','Blue','Masculine')
insert into Appearance values(17,'Black','Black','Masculine')
insert into Appearance values(18,'Black','Brown','Feminine')
-----------------------------------------------------------------



-- pirmary key = row value + first digit of each attribute
insert into Attributes(Attribute_ID , MagicPower , Dexterity , Strength , Mana , Magic_Resistanse , Armor , Max_Health)
values(04241564,45,23,41,150,57,61,495)
insert into attributes values (14241513,45,23,41,150,54,10,395)
insert into attributes values (21111214,10,14,13,123,23,14,400)
insert into attributes values (32431452,23,43,32,112,43,56,298)
insert into attributes values (42149153,20,13,41,90,10,52,345)
insert into attributes values (51147333,13,14,43,78,34,32,330)
insert into attributes values (61451533,16,43,51,139,50,37,397)
insert into attributes values (73334422,35,31,32,49,43,28,289)
insert into attributes values (82434424,24,42,31,43,47,27,425)
insert into attributes values (91142133,12,11,45,240,18,36,390)
insert into attributes values (103142311,32,10,41,200,35,19,145)
-----------------------------------------------------------------


insert into Authority(Authority_Type , Authority_ID , Can_Banish , Can_Kick , Can_Timeout , Can_Block)
values ('Admin',0,1,1,1,1)
insert into Authority values('Player',1,0,0,0,1)
insert into Authority values('GM',2,0,1,1,1)
insert into Authority values('Player',3,0,1,1,1)
insert into Authority values('Executive',4,1,1,1,1)


-----------------------------------------------------------------

insert into Factions(Faction_ID,Donation,Faction_Name)
values(0,0,'DRAGONX')
insert into Factions values(1,7300,'GPEX')


-----------------------------------------------------------------

insert into Inventory (Inventory_ID,Capacity,Current_Amount)
values (0,50,15)
insert into Inventory values(1,50,50)
insert into Inventory values(2,50,14)
insert into Inventory values(3,50,23)
insert into Inventory values(4,50,24)
insert into Inventory values(5,50,31)
insert into Inventory values(6,60,42)

-----------------------------------------------------------------

-- primary key = starts with 1 if melee , 2 if ranged , 3 if shield , 4 if consumable , 5 if pet , 6 if armor
-- + type number  + item place

-- melee types
-- 0 if sword , 1 if greatsword , 2 if polearm , 3 if dagger , 4 if mace , 5 if hammer
-- ranged types
-- 0 if short-bows , 1 if long-bows , 2 if crossbows , 3 if pistols , 4 if wands , 5 if staff , 6 if darts
-- shield types
-- 0 if kite-shield , 1 if buckler , 2 if tower-shield, 3 if parrying dagger
-- consumable types
-- 0 if Healt-Potions , 1 if Mana-Potions , 2 if buff-potions , 3 if scrolls , 4 if food
-- pet types
-- 0 if mount , 1 if not
-- armor types
-- 0 if medium-grade , 1 if light-grade , 2 if heavy-grade ,3 if superheavy-grade ,4 if superlight-grade
insert into Items (Item_ID,Item_Name,Req_Level,Item_Stats)
values(100,'Novice Blade',25,16)
insert into Items values(101,'Rusted Sword',27,19)
insert into Items values(1232,'glaive of the bandit lord',27,19)
insert into Items values(1342,'fang of the mountain lord',27,19)
insert into Items values(1426,'skull crusher',27,19)
insert into Items values(1574,'valley creator',27,19)
insert into Items values(2017,'short bow of the mounted warior',27,19)
insert into Items values(2556,'staff of necromancy',27,19)
insert into Items values(2127,'WindWisperer',27,19)
insert into Items values(222,'standart crossbow',27,19)
insert into Items values(3112,'steel buckler',27,19)
insert into Items values(3234,'BoneMass',27,19)
insert into Items values(333,'dull dagger',27,19)
insert into Items values(402,'lesser healing potion',27,19)
insert into Items values(405,'greater healing potion',27,19)
insert into Items values(412,'lesser mana potion',27,19)
insert into Items values(432,'Scroll of Idetification',27,19)
insert into Items values(500,'Standart War Horse',27,19)
insert into Items values(5042,'flash the sky soverign',27,19)
insert into Items values(5112,'Hunter Dof',27,19)
insert into Items values(600,'standart issue chain mail',27,19)
insert into Items values(626,'iron plate armor',27,19)
insert into Items values(6345,'Drake Scale armor',27,19)
insert into Items values(1032,'Drake Scale sword',33,19)




-----------------------------------------------------------------


insert into Monsters(Monster_ID,Monster_Reward,Attribute_ID)
values(16,210,21111214)
insert into Monsters values(17,3200,51147333)

-----------------------------------------------------------------

insert into NPC (NPC_ID,NPC_Name,Attribute_ID)
values(0,'Fisherman',82434424)
insert into NPC values(1,'blacksmith',91142133)


-----------------------------------------------------------------

insert into Proficiency (Proficiency_ID,Magic_Level,Melee_Level,Ranged_Level,Blocking_Level)
values(11,23,25,40,30)
insert into Proficiency values(12,24,16,17,35)

-----------------------------------------------------------------


insert into Quests(Quest_ID,Description,Reward_Amount,Quest_Name,NPC_ID)
values(20,NULL,2460,'Avalanche',0)

insert into Quests values(21,NULL,2970,'journey throug sea',1)

-----------------------------------------------------------------

insert into Server(Server_ID,Server_IP,Server_Location)
values(0,'192.168.1.1','E WEST')
insert into Server values(1,'192.168.1.1','Turkey')

-----------------------------------------------------------------

insert into Membership_Account(Account_ID , User_Name , Password , email_Address , Authority_Type , Authority_ID , Server_ID , Server_IP)
values(0,'Yasaki','295113','aktar25@gmail.com','Player',1,0,'192.168.1.1')
insert into Membership_Account values(1,'Karina_32','A!_ammfae','asd@gmail.com','Player',1,0,'192.168.1.1')
insert into Membership_Account values(2,'MASKLESS','B%SNgAc','abc@gmail.com','Player',1,0,'192.168.1.1')
insert into Membership_Account values(3,'DarkKnight','Jkjncw 0','jkl@gmail.com','Admin',0,0,'192.168.1.1')
insert into Membership_Account values(4,'DE4thIsC0mming','9eEfnv!#','xyz@gmail.com','GM',3,0,'192.168.1.1')


-----------------------------------------------------------------

insert into Player_Character(Character_ID,Character_Name,Character_Level,Character_XP,Character_Req_XP,Appearance_ID,Inventory_ID,Attribute_ID,Faction_ID,Account_ID)
values(14,'Black Widow',26,5000,7500,16,0,91142133,NULL,3)
insert into Player_Character values(15,'Dare Devil',72,3000,4500,17,1,82434424,1,2)
insert into Player_Character values(16,'BigGuy',46,3000,4500,17,1,91142133,NULL,2)
insert into Player_Character values(17,'MisterHammer',52,3000,4500,18,2,14241513,NULL,5)



-----------------------------------------------------------------

insert into Skills(Skills_ID,Skill_Cost,Skill_Range)
values(9,173,54)
insert into Skills values(10,85,19)

-----------------------------------------------------------------

insert into WILL_FOLLOW(Character_ID,Quest_ID,isActive)
values(14,20,1)
insert into WILL_FOLLOW values(15,21,0)



-----------------------------------------------------------------

insert into Achives (Achivement_ID,Account_ID)
values(2,1)
insert into Achives values(2,2)
insert into Achives values(2,3)
insert into Achives values(5,4)
insert into Achives values(6,4)
insert into Achives values(7,4)

-----------------------------------------------------------------


insert into CanUse (Skills_ID,Character_ID,Req_Prof_Level) 
values(9,14,23)
insert into CanUse values(10,15,12)

-----------------------------------------------------------------

insert into Friends_with (account_id_1,account_id_2,Friendship_Start_Date)
values(1,3,GETDATE())


-----------------------------------------------------------------

insert into Learns (Character_ID,Proficiency_ID)
values(14,11)

insert into Learns values(15,12)


-----------------------------------------------------------------


insert into Contains_ (Inventory_ID,Item_ID)
values(2,1232)
insert into Contains_ values(2,1342)
insert into Contains_ values(2,2556)
insert into Contains_ values(4,3234)
insert into Contains_ values(6,5042)
insert into Contains_ values(3,3112)
