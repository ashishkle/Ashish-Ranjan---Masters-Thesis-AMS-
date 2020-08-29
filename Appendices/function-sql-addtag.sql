DELIMITER $$
CREATE FUNCTION freshrss.vendortag(
	newsfeed text CHARSET utf8mb4 Collate utf8mb4_unicode_ci
) RETURNS varchar(100) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	DECLARE finished INTEGER DEFAULT 0;
	DECLARE vendortag varchar(100) DEFAULT "";
    DECLARE vendortaglist varchar(100) DEFAULT "";
	
	-- declare cursor for vendortag
	DEClARE curvendortag
		CURSOR FOR 
			SELECT tag_value FROM freshrss.on2it_tag;
	-- declare NOT FOUND handler
	DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;
	DECLARE CONTINUE HANDLER FOR 1366 BEGIN END;
	OPEN curvendortag;

	gettag: LOOP
		FETCH curvendortag INTO vendortag;
		IF finished = 1 THEN 
			LEAVE gettag;
		END IF;
		-- build tag list
        IF newsfeed  REGEXP vendortag  THEN
		SET vendortaglist = CONCAT("#",vendortag,vendortaglist);
        END IF;
	END LOOP gettag;
	CLOSE curvendortag;
RETURN (vendortaglist);
END$$
DELIMITER ;