-- BOLD_UPGRADE_RERUN_SAFE: true
-- BOLD_UPGRADE_IDEMPOTENT_VALIDATED: true
-- BOLD_UPGRADE_STATEMENT_SEPARATOR: $$

DECLARE
    constraint_count NUMBER;
BEGIN
    SELECT COUNT(DISTINCT c.CONSTRAINT_NAME)
    INTO constraint_count
    FROM USER_CONSTRAINTS c
    JOIN USER_CONS_COLUMNS cc ON c.CONSTRAINT_NAME = cc.CONSTRAINT_NAME AND c.TABLE_NAME = cc.TABLE_NAME
    WHERE c.TABLE_NAME = UPPER('BOLDBI_PublishType')
      AND c.CONSTRAINT_TYPE = 'U'
      AND cc.COLUMN_NAME = UPPER('Name')
      AND 1 = (
          SELECT COUNT(*)
          FROM USER_CONS_COLUMNS cc2
          WHERE cc2.CONSTRAINT_NAME = c.CONSTRAINT_NAME
            AND cc2.TABLE_NAME = c.TABLE_NAME
      );

    IF constraint_count = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE BOLDBI_PublishType ADD CONSTRAINT UQ_BOLDBI_PUBLISHTYPE_NAME UNIQUE (Name)';
    END IF;
END;
$$

DECLARE
    constraint_count NUMBER;
BEGIN
    SELECT COUNT(DISTINCT c.CONSTRAINT_NAME)
    INTO constraint_count
    FROM USER_CONSTRAINTS c
    JOIN USER_CONS_COLUMNS cc ON c.CONSTRAINT_NAME = cc.CONSTRAINT_NAME AND c.TABLE_NAME = cc.TABLE_NAME
    WHERE c.TABLE_NAME = UPPER('BOLDBI_GroupLogType')
      AND c.CONSTRAINT_TYPE = 'U'
      AND cc.COLUMN_NAME = UPPER('Name')
      AND 1 = (
          SELECT COUNT(*)
          FROM USER_CONS_COLUMNS cc2
          WHERE cc2.CONSTRAINT_NAME = c.CONSTRAINT_NAME
            AND cc2.TABLE_NAME = c.TABLE_NAME
      );

    IF constraint_count = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE BOLDBI_GroupLogType ADD CONSTRAINT UQ_BOLDBI_GROUPLOGTYPE_NAME UNIQUE (Name)';
    END IF;
END;
$$

DECLARE
    column_count NUMBER;
    valid_column_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO column_count
    FROM USER_TAB_COLUMNS
    WHERE TABLE_NAME = UPPER('BOLDBI_Item')
      AND COLUMN_NAME = UPPER('DashboardLogo');

    IF column_count = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE BOLDBI_Item ADD DashboardLogo NVARCHAR2(1026)';
    ELSE
        SELECT COUNT(*) INTO valid_column_count
        FROM USER_TAB_COLUMNS
        WHERE TABLE_NAME = UPPER('BOLDBI_Item')
          AND COLUMN_NAME = UPPER('DashboardLogo')
          AND DATA_TYPE = 'NVARCHAR2'
          AND CHAR_LENGTH = 1026
          AND NULLABLE = 'Y';

        IF valid_column_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'BOLD_UPGRADE_VALIDATION_FAILED: BOLDBI_Item.DashboardLogo exists with an unexpected definition.');
        END IF;
    END IF;
END;
$$

DECLARE
    column_count NUMBER;
    valid_column_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO column_count
    FROM USER_TAB_COLUMNS
    WHERE TABLE_NAME = UPPER('BOLDBI_ScheduleDetail')
      AND COLUMN_NAME = UPPER('AIInsightSummaryEnabled');

    IF column_count = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE BOLDBI_ScheduleDetail ADD AIInsightSummaryEnabled NUMBER(1, 0) DEFAULT 0 NOT NULL';
    ELSE
        SELECT COUNT(*) INTO valid_column_count
        FROM USER_TAB_COLUMNS
        WHERE TABLE_NAME = UPPER('BOLDBI_ScheduleDetail')
          AND COLUMN_NAME = UPPER('AIInsightSummaryEnabled')
          AND DATA_TYPE = 'NUMBER'
          AND DATA_PRECISION = 1
          AND DATA_SCALE = 0
          AND NULLABLE = 'N';

        IF valid_column_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'BOLD_UPGRADE_VALIDATION_FAILED: BOLDBI_ScheduleDetail.AIInsightSummaryEnabled exists with an unexpected definition.');
        END IF;
    END IF;
END;
$$

DECLARE
    column_count NUMBER;
    valid_column_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO column_count
    FROM USER_TAB_COLUMNS
    WHERE TABLE_NAME = UPPER('BOLDBI_AI_SESSIONS')
      AND COLUMN_NAME = 'RequestType';

    IF column_count = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE BOLDBI_AI_SESSIONS ADD ("RequestType" VARCHAR2(255))';
    ELSE
        SELECT COUNT(*) INTO valid_column_count
        FROM USER_TAB_COLUMNS
        WHERE TABLE_NAME = UPPER('BOLDBI_AI_SESSIONS')
          AND COLUMN_NAME = 'RequestType'
          AND DATA_TYPE = 'VARCHAR2'
          AND CHAR_LENGTH = 255
          AND NULLABLE = 'Y';

        IF valid_column_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'BOLD_UPGRADE_VALIDATION_FAILED: BOLDBI_AI_SESSIONS.RequestType exists with an unexpected definition.');
        END IF;
    END IF;
END;
$$

DECLARE
    column_count NUMBER;
    valid_column_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO column_count
    FROM USER_TAB_COLUMNS
    WHERE TABLE_NAME = UPPER('BOLDBI_AI_SESSIONS')
      AND COLUMN_NAME = 'SessionName';

    IF column_count = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE BOLDBI_AI_SESSIONS ADD ("SessionName" VARCHAR2(4000))';
    ELSE
        SELECT COUNT(*) INTO valid_column_count
        FROM USER_TAB_COLUMNS
        WHERE TABLE_NAME = UPPER('BOLDBI_AI_SESSIONS')
          AND COLUMN_NAME = 'SessionName'
          AND DATA_TYPE = 'VARCHAR2'
          AND CHAR_LENGTH = 4000
          AND NULLABLE = 'Y';

        IF valid_column_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'BOLD_UPGRADE_VALIDATION_FAILED: BOLDBI_AI_SESSIONS.SessionName exists with an unexpected definition.');
        END IF;
    END IF;
END;
$$

DECLARE
    column_count NUMBER;
    valid_column_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO column_count
    FROM USER_TAB_COLUMNS
    WHERE TABLE_NAME = UPPER('BOLDBI_AI_SESSIONS')
      AND COLUMN_NAME = 'IsActive';

    IF column_count = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE BOLDBI_AI_SESSIONS ADD ("IsActive" NUMBER(1,0))';
    ELSE
        SELECT COUNT(*) INTO valid_column_count
        FROM USER_TAB_COLUMNS
        WHERE TABLE_NAME = UPPER('BOLDBI_AI_SESSIONS')
          AND COLUMN_NAME = 'IsActive'
          AND DATA_TYPE = 'NUMBER'
          AND DATA_PRECISION = 1
          AND DATA_SCALE = 0
          AND NULLABLE = 'Y';

        IF valid_column_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'BOLD_UPGRADE_VALIDATION_FAILED: BOLDBI_AI_SESSIONS.IsActive exists with an unexpected definition.');
        END IF;
    END IF;
END;
$$

DECLARE
    column_count NUMBER;
    valid_column_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO column_count
    FROM USER_TAB_COLUMNS
    WHERE TABLE_NAME = UPPER('BOLDBI_AI_SESSIONS')
      AND COLUMN_NAME = 'HistoryContent';

    IF column_count = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE BOLDBI_AI_SESSIONS ADD ("HistoryContent" VARCHAR2(4000))';
    ELSE
        SELECT COUNT(*) INTO valid_column_count
        FROM USER_TAB_COLUMNS
        WHERE TABLE_NAME = UPPER('BOLDBI_AI_SESSIONS')
          AND COLUMN_NAME = 'HistoryContent'
          AND DATA_TYPE = 'VARCHAR2'
          AND CHAR_LENGTH = 4000
          AND NULLABLE = 'Y';

        IF valid_column_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'BOLD_UPGRADE_VALIDATION_FAILED: BOLDBI_AI_SESSIONS.HistoryContent exists with an unexpected definition.');
        END IF;
    END IF;
END;
$$

DECLARE
    column_count NUMBER;
    valid_column_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO column_count
    FROM USER_TAB_COLUMNS
    WHERE TABLE_NAME = UPPER('BOLDBI_AI_SESSIONS')
      AND COLUMN_NAME = 'SessionModifiedTime';

    IF column_count = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE BOLDBI_AI_SESSIONS ADD ("SessionModifiedTime" TIMESTAMP WITH TIME ZONE)';
    ELSE
        SELECT COUNT(*) INTO valid_column_count
        FROM USER_TAB_COLUMNS
        WHERE TABLE_NAME = UPPER('BOLDBI_AI_SESSIONS')
          AND COLUMN_NAME = 'SessionModifiedTime'
          AND DATA_TYPE LIKE 'TIMESTAMP%'
          AND NULLABLE = 'Y';

        IF valid_column_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'BOLD_UPGRADE_VALIDATION_FAILED: BOLDBI_AI_SESSIONS.SessionModifiedTime exists with an unexpected definition.');
        END IF;
    END IF;
END;
$$

DECLARE
    column_count NUMBER;
    valid_column_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO column_count
    FROM USER_TAB_COLUMNS
    WHERE TABLE_NAME = UPPER('BOLDBI_ItemLog')
      AND COLUMN_NAME = UPPER('IPAddress');

    IF column_count = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE BOLDBI_ItemLog ADD IPAddress NVARCHAR2(255)';
    ELSE
        SELECT COUNT(*) INTO valid_column_count
        FROM USER_TAB_COLUMNS
        WHERE TABLE_NAME = UPPER('BOLDBI_ItemLog')
          AND COLUMN_NAME = UPPER('IPAddress')
          AND DATA_TYPE = 'NVARCHAR2'
          AND CHAR_LENGTH = 255
          AND NULLABLE = 'Y';

        IF valid_column_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'BOLD_UPGRADE_VALIDATION_FAILED: BOLDBI_ItemLog.IPAddress exists with an unexpected definition.');
        END IF;
    END IF;
END;
$$
