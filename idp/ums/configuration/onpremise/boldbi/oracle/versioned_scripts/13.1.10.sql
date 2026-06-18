-- BOLD_UPGRADE_RERUN_SAFE: true
-- BOLD_UPGRADE_IDEMPOTENT_VALIDATED: true
-- BOLD_UPGRADE_STATEMENT_SEPARATOR: $$

DECLARE
    column_count NUMBER;
    valid_column_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO column_count
    FROM USER_TAB_COLUMNS
    WHERE TABLE_NAME = UPPER('BOLDBI_Group')
      AND COLUMN_NAME = UPPER('GroupLogo');

    IF column_count = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE BOLDBI_Group ADD GroupLogo NVARCHAR2(1026) NULL';
    ELSE
        SELECT COUNT(*)
        INTO valid_column_count
        FROM USER_TAB_COLUMNS
        WHERE TABLE_NAME = UPPER('BOLDBI_Group')
          AND COLUMN_NAME = UPPER('GroupLogo')
          AND DATA_TYPE = 'NVARCHAR2'
          AND CHAR_LENGTH = 1026
          AND NULLABLE = 'Y';

        IF valid_column_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'BOLD_UPGRADE_VALIDATION_FAILED: BOLDBI_Group.GroupLogo exists with an unexpected definition.');
        END IF;
    END IF;
END;
$$

DECLARE
    column_count NUMBER;
    valid_column_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO column_count
    FROM USER_TAB_COLUMNS
    WHERE TABLE_NAME = UPPER('BOLDBI_Item')
      AND COLUMN_NAME = UPPER('PublishedDate');

    IF column_count = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE BOLDBI_Item ADD PublishedDate TIMESTAMP NULL';
    ELSE
        SELECT COUNT(*)
        INTO valid_column_count
        FROM USER_TAB_COLUMNS
        WHERE TABLE_NAME = UPPER('BOLDBI_Item')
          AND COLUMN_NAME = UPPER('PublishedDate')
          AND DATA_TYPE LIKE 'TIMESTAMP%'
          AND NULLABLE = 'Y';

        IF valid_column_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'BOLD_UPGRADE_VALIDATION_FAILED: BOLDBI_Item.PublishedDate exists with an unexpected definition.');
        END IF;
    END IF;
END;
$$

DECLARE
    row_count NUMBER;
    valid_row_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO row_count
    FROM BOLDBI_ExportType
    WHERE Name = 'DatasourceCache';

    SELECT COUNT(*)
    INTO valid_row_count
    FROM BOLDBI_ExportType
    WHERE Name = 'DatasourceCache'
      AND IsActive = 1;

    IF row_count = 0 THEN
        INSERT INTO BOLDBI_ExportType (Name, IsActive) VALUES ('DatasourceCache', 1);
    ELSIF row_count != valid_row_count THEN
        RAISE_APPLICATION_ERROR(-20001, 'BOLD_UPGRADE_VALIDATION_FAILED: BOLDBI_ExportType.DatasourceCache exists with unexpected values.');
    END IF;
END;
$$
