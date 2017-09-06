--------------------------------
-- run against systemdb database
--------------------------------

-- check AFL PAL functions are installed
SELECT * FROM SYS.AFL_FUNCTIONS WHERE PACKAGE_NAME='PAL' AND FUNCTION_NAME LIKE '%_ANY';

-- check tenant database exists and is started
SELECT * FROM SYS.M_DATABASES;

-- add script server to tenant database
ALTER DATABASE HXE ADD 'scriptserver';


------------------------------
-- run against tenant database
------------------------------

-- check script server
SELECT * FROM SYS.M_SERVICES;

-- create user for PAL development
CREATE USER DEVUSER PASSWORD Password1;

-- authorize access to SYS views
GRANT CATALOG READ TO DEVUSER;

-- authorize creation & removal of PAL procedures
GRANT AFLPM_CREATOR_ERASER_EXECUTE TO DEVUSER;

-- authorize execution of PAL procedures
GRANT AFL__SYS_AFL_AFLPAL_EXECUTE TO DEVUSER;

-- authorize WebIDE developers to access AFL metadata
GRANT SELECT ON "_SYS"."AFL_AREAS" TO "SYS_XS_HANA_BROKER"."XSA_DEV_USER_ROLE";
GRANT SELECT ON "_SYS"."AFL_FUNCTION_PARAMETERS" TO "SYS_XS_HANA_BROKER"."XSA_DEV_USER_ROLE";
GRANT SELECT ON "_SYS"."AFL_FUNCTION_PROPERTIES" TO "SYS_XS_HANA_BROKER"."XSA_DEV_USER_ROLE";
GRANT SELECT ON "_SYS"."AFL_FUNCTIONS" TO "SYS_XS_HANA_BROKER"."XSA_DEV_USER_ROLE";
GRANT SELECT ON "_SYS"."AFL_PACKAGES" TO "SYS_XS_HANA_BROKER"."XSA_DEV_USER_ROLE";
GRANT SELECT ON "_SYS"."AFL_TEXTS" TO "SYS_XS_HANA_BROKER"."XSA_DEV_USER_ROLE";

-- authorize HDI container owner to access AFL metadata
GRANT SELECT ON "_SYS"."AFL_AREAS" TO "_SYS_DI_OO_DEFAULTS";
GRANT SELECT ON "_SYS"."AFL_FUNCTION_PARAMETERS" TO "_SYS_DI_OO_DEFAULTS";
GRANT SELECT ON "_SYS"."AFL_FUNCTION_PROPERTIES" TO "_SYS_DI_OO_DEFAULTS";
GRANT SELECT ON "_SYS"."AFL_FUNCTIONS" TO "_SYS_DI_OO_DEFAULTS";
GRANT SELECT ON "_SYS"."AFL_PACKAGES" TO "_SYS_DI_OO_DEFAULTS";
GRANT SELECT ON "_SYS"."AFL_TEXTS" TO "_SYS_DI_OO_DEFAULTS";

-- authorize HDI container owner to execute PAL procedures
GRANT AFL__SYS_AFL_AFLPAL_EXECUTE TO "_SYS_DI_OO_DEFAULTS";

