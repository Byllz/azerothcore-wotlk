-- DB update 2021_06_13_02 -> 2021_06_13_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_13_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_13_02 2021_06_13_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1622868444362039500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622868444362039500');

SET @NPC = 17610;

UPDATE `creature` 
SET `position_x` = -505.063416, `position_y` = 1155.307861, `position_z` = 63.713577, `wander_distance` = 10, `MovementType` = 1 
WHERE `guid` = @NPC;
--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_13_03' WHERE sql_rev = '1622868444362039500';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;