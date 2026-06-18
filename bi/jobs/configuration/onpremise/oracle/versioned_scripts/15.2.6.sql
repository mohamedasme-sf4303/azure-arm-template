ALTER TABLE BOLDBI_ApiKeyDetails ADD IsApiKeyViewed NUMBER(1, 0) DEFAULT 1 NOT NULL;

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
    WHERE TABLE_NAME = UPPER('BOLDBI_ApiKeyDetails')
      AND COLUMN_NAME = UPPER('IsApiKeyViewed');

    IF column_count = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE BOLDBI_ApiKeyDetails ADD IsApiKeyViewed NUMBER(1, 0) DEFAULT 1 NOT NULL';
    ELSE
        SELECT COUNT(*)
        INTO valid_column_count
        FROM USER_TAB_COLUMNS
        WHERE TABLE_NAME = UPPER('BOLDBI_ApiKeyDetails')
          AND COLUMN_NAME = UPPER('IsApiKeyViewed')
          AND DATA_TYPE = 'NUMBER'
          AND DATA_PRECISION = 1
          AND DATA_SCALE = 0
          AND NULLABLE = 'N';

        IF valid_column_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'BOLD_UPGRADE_VALIDATION_FAILED: BOLDBI_ApiKeyDetails.IsApiKeyViewed exists with an unexpected definition.');
        END IF;
    END IF;
END;
$$
