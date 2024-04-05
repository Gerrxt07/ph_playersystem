-- By executing the SQL code you create a new database with finished tables. Please don't use that file if you already have a database for Phantom Scripts.
CREATE DATABASE phantom;
USE phantom;

CREATE TABLE IF NOT EXISTS `phuser` (
  `player_id` INT(11) NOT NULL AUTO_INCREMENT, -- Unique ID for each user in the database
  `player_name` VARCHAR(255) DEFAULT NULL, -- FiveM account name
  `discord_id` VARCHAR(255) DEFAULT NULL, -- Discord account ID
  `ip` VARCHAR(255) DEFAULT NULL,  -- IP address of the user (last known)
  `admin` VARCHAR(8) NOT NULL DEFAULT 'false', -- Admin status (true/false)
  PRIMARY KEY (`player_id`), -- Primary key of the table
  UNIQUE KEY `discord_id` (`discord_id`) -- Unique key for the Discord ID

) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;