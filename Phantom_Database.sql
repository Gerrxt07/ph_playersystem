-- By executing the SQL code you create a new database with finished tables. Please don't use that file if you already have a database for Phantom Scripts.
CREATE DATABASE phantom;
USE phantom;

CREATE TABLE IF NOT EXISTS `user` (
  `player_id` INT(11) NOT NULL AUTO_INCREMENT, -- Unique ID for each user in the database
  `player_name` VARCHAR(255) DEFAULT NULL, -- FiveM account name
  `discord_id` VARCHAR(255) DEFAULT NULL, -- Discord account ID
  `ip` VARCHAR(255) DEFAULT NULL,  -- IP address of the user (last known)
  `admin` VARCHAR(8) NOT NULL DEFAULT 'false', -- Admin status (true/false)
  PRIMARY KEY (`player_id`), -- Primary key of the table
  UNIQUE KEY `discord_id` (`discord_id`) -- Unique key for the Discord ID

) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `cars` (
  `car_id` INT(11) NOT NULL AUTO_INCREMENT, -- Unique ID for each car in the database
  `character_id` INT(11) NOT NULL, -- ID of the character who owns the car (Reference to the `char` table)
  `car_model` VARCHAR(50) NOT NULL, -- Model of the car (e.g. `adder`)
  `frame_number` VARCHAR(12) NOT NULL, -- Chassis number of the car (VIN)
  `plate` VARCHAR(8) NOT NULL, -- License plate of the car (e.g. `ABCD123`)
  `registered` VARCHAR(5) NOT NULL DEFAULT 'false', -- Registration status (true/false)
  `insured` VARCHAR(5) NOT NULL DEFAULT 'false', -- Insurance status (true/false)
  `parked` VARCHAR(5) NOT NULL DEFAULT 'false', -- Parking status (true/false)
  `impound` VARCHAR(5) NOT NULL DEFAULT 'false', -- Impound status (true/false)
  `type` VARCHAR(8) NOT NULL DEFAULT 'civilian', -- Type of the car (e.g. `civilian` or `state`)
  PRIMARY KEY (`car_id`), -- Primary key of the table
  UNIQUE KEY `car_id` (`car_id`), -- The Car ID is unique
  UNIQUE KEY `frame_number` (`frame_number`) -- The Frame number is unique

) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `char` (
  `character_id` INT(11) NOT NULL AUTO_INCREMENT, -- Unique ID for each character in the database
  `player_id` INT(11) NOT NULL, -- ID of the user who owns the character (Reference to the `user` table)
  `name` VARCHAR(255) NOT NULL, -- Name of the character
  `birthday` VARCHAR(255) NOT NULL, -- Birthday of the character
  `job` VARCHAR(50) NOT NULL, -- Job of the character
  `phone_number` INT(11) NOT NULL, -- Phone number of the character
  PRIMARY KEY (`character_id`), -- Primary key of the table
  UNIQUE KEY `character_id` (`character_id`), -- The Character ID is unique
  UNIQUE KEY `phone_number` (`phone_number`) -- The Phone Number is unique
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;