SET SCHEMA PRGOEL;

DROP TYPE DC_PAL_RF_DATA_T;
CREATE TYPE DC_PAL_RF_DATA_T AS TABLE(
id DOUBLE ,
loan_status INTEGER ,
loan_amnt INTEGER ,
funded_amnt INTEGER ,
funded_amnt_inv DOUBLE,
term INTEGER ,
int_rate DOUBLE,
installment DOUBLE,
grade INTEGER ,
sub_grade INTEGER ,
emp_length DOUBLE,
annual_inc DOUBLE,
issue_d NVARCHAR(6), 
zip_code INTEGER ,
dti DOUBLE,
delinq_2yrs INTEGER ,
earliest_cr_line NVARCHAR(6), 
inq_last_6mths INTEGER ,
mths_since_last_delinq INTEGER ,
mths_since_last_record INTEGER ,
open_acc INTEGER ,
pub_rec INTEGER ,
revol_bal INTEGER ,
revol_util DOUBLE,
total_acc INTEGER ,
out_prncp INTEGER ,
out_prncp_inv INTEGER ,
total_rec_int DOUBLE,
last_pymnt_d NVARCHAR(6), 
next_pymnt_d NVARCHAR(5), 
last_credit_pull_d NVARCHAR(6) ,
pub_rec_bankruptcies INTEGER ,
monthly_inc DOUBLE,
column2 DOUBLE,
home_ownership_mortgage INTEGER ,
home_ownership_none INTEGER ,
home_ownership_other INTEGER ,
home_ownership_own INTEGER ,
home_ownership_rent INTEGER ,
verification_status_not_verified INTEGER ,
verification_status_source_verified INTEGER ,
verification_status_verified INTEGER ,
purpose_car INTEGER ,
purpose_credit_card INTEGER ,
purpose_debt_consolidation INTEGER ,
purpose_educational INTEGER ,
purpose_home_improvement INTEGER ,
purpose_house INTEGER ,
purpose_major_purchase INTEGER ,
purpose_medical INTEGER ,
purpose_moving INTEGER ,
purpose_other INTEGER ,
purpose_renewable_energy INTEGER ,
purpose_small_business INTEGER ,
purpose_vacation INTEGER ,
purpose_wedding INTEGER ,
addr_state_ak INTEGER ,
addr_state_al INTEGER ,
addr_state_ar INTEGER ,
addr_state_az INTEGER ,
addr_state_ca INTEGER ,
addr_state_co INTEGER ,
addr_state_ct INTEGER ,
addr_state_dc INTEGER ,
addr_state_de INTEGER ,
addr_state_fl INTEGER ,
addr_state_ga INTEGER ,
addr_state_hi INTEGER ,
addr_state_ia INTEGER ,
addr_state_id INTEGER ,
addr_state_il INTEGER ,
addr_state_in INTEGER ,
addr_state_ks INTEGER ,
addr_state_ky INTEGER ,
addr_state_la INTEGER ,
addr_state_ma INTEGER ,
addr_state_md INTEGER ,
addr_state_me INTEGER ,
addr_state_mi INTEGER ,
addr_state_mn INTEGER ,
addr_state_mo INTEGER ,
addr_state_ms INTEGER ,
addr_state_mt INTEGER ,
addr_state_nc INTEGER ,
addr_state_ne INTEGER ,
addr_state_nh INTEGER ,
addr_state_nj INTEGER ,
addr_state_nm INTEGER ,
addr_state_nv INTEGER ,
addr_state_ny INTEGER ,
addr_state_oh INTEGER ,
addr_state_ok INTEGER ,
addr_state_or INTEGER ,
addr_state_pa INTEGER ,
addr_state_ri INTEGER ,
addr_state_sc INTEGER ,
addr_state_sd INTEGER ,
addr_state_tn INTEGER ,
addr_state_tx INTEGER ,
addr_state_ut INTEGER ,
addr_state_va INTEGER ,
addr_state_vt INTEGER ,
addr_state_wa INTEGER ,
addr_state_wi INTEGER ,
addr_state_wv INTEGER ,
addr_state_wy INTEGER ,
annual_1 DOUBLE,
column3 DOUBLE


);

DROP TYPE DC_PAL_RF_MODEL_T;
CREATE TYPE DC_PAL_RF_MODEL_T AS TABLE(
	"id" INTEGER,
	"TREEINDEX" INTEGER,
	"MODEL" VARCHAR(5000)
);



DROP TYPE DC_PAL_RF_VAR_IMP_T;
CREATE TYPE DC_PAL_RF_VAR_IMP_T AS TABLE(
	"VAR" VARCHAR(100),
	"IMP" DOUBLE
);


DROP TYPE DC_PAL_RF_ERR_RATE_T;

CREATE TYPE DC_PAL_RF_ERR_RATE_T AS TABLE(
	"TREEINDEX" INTEGER,
	"ERR" DOUBLE
);


DROP TYPE DC_PAL_RF_CONFUSION_T;
CREATE TYPE DC_PAL_RF_CONFUSION_T AS TABLE(
	"id" INTEGER,
	"CONTENT" VARCHAR(1000)
);


DROP TYPE DC_PAL_CONTROL_T;
CREATE TYPE DC_PAL_CONTROL_T AS TABLE(
	"NAME" VARCHAR (100),
	"INTARGS" INTEGER, 
	"DOUBLEARGS" DOUBLE,
	"STRINGARGS" VARCHAR(100)
);

DROP TABLE DC_PAL_RF_PDATA_TBL;
CREATE COLUMN TABLE DC_PAL_RF_PDATA_TBL(
	"POSITION" INT,
	"SCHEMA_NAME" NVARCHAR(256),
	"TYPE_NAME" NVARCHAR(256),
	"PARAMETER_TYPE" VARCHAR(7)
);

INSERT INTO DC_PAL_RF_PDATA_TBL VALUES (1, 'PRGOEL', 'DC_PAL_RF_DATA_T', 'in'); 
INSERT INTO DC_PAL_RF_PDATA_TBL VALUES (2, 'PRGOEL', 'DC_PAL_CONTROL_T', 'in'); 
INSERT INTO DC_PAL_RF_PDATA_TBL VALUES (3, 'PRGOEL', 'DC_PAL_RF_MODEL_T', 'out');
INSERT INTO DC_PAL_RF_PDATA_TBL VALUES (4, 'PRGOEL', 'DC_PAL_RF_VAR_IMP_T', 'out'); 
INSERT INTO DC_PAL_RF_PDATA_TBL VALUES (5, 'PRGOEL', 'DC_PAL_RF_ERR_RATE_T', 'out'); 
INSERT INTO DC_PAL_RF_PDATA_TBL VALUES (6, 'PRGOEL', 'DC_PAL_RF_CONFUSION_T', 'out'); 

CALL "SYS".AFLLANG_WRAPPER_PROCEDURE_DROP('PRGOEL', 'DC_PAL_RF_TRAINING_PROC_V2');

CALL "SYS".AFLLANG_WRAPPER_PROCEDURE_CREATE('AFLPAL', 'RANDOMFORESTTRAIN', 'PRGOEL', 'DC_PAL_RF_TRAINING_PROC_V2', DC_PAL_RF_PDATA_TBL);


DROP TABLE #PAL_CONTROL_TBL;
CREATE LOCAL TEMPORARY COLUMN TABLE #PAL_CONTROL_TBL(
	"NAME" VARCHAR (100), 
	"INTARGS" INTEGER, 
	"DOUBLEARGS" DOUBLE, 
	"STRINGARGS" VARCHAR (100)
);

INSERT INTO #PAL_CONTROL_TBL VALUES ('TREES_NUM', 300, null,null);
INSERT INTO #PAL_CONTROL_TBL VALUES ('TRY_NUM', 3, null,null);
INSERT INTO #PAL_CONTROL_TBL VALUES ('SEED', 2, null,null);

DROP TABLE PAL_RF_MODEL_TBL;
CREATE COLUMN TABLE PAL_RF_MODEL_TBL LIKE PAL_RF_MODEL_T;

DROP TABLE PAL_RF_VAR_IMP_TBL;
CREATE COLUMN TABLE PAL_RF_VAR_IMP_TBL LIKE PAL_RF_VAR_IMP_T;

DROP TABLE PAL_RF_ERR_RATE_TBL;
CREATE COLUMN TABLE PAL_RF_ERR_RATE_TBL LIKE PAL_RF_ERR_RATE_T;

DROP TABLE PAL_RF_CONFUSION_TBL;
CREATE COLUMN TABLE PAL_RF_CONFUSION_TBL LIKE PAL_RF_CONFUSION_T;

CALL "PRGOEL".DC_PAL_RF_TRAINING_PROC_V2("PRGOEL"."TBL_INPUT_DATA", #PAL_CONTROL_TBL, PAL_RF_MODEL_TBL, PAL_RF_VAR_IMP_TBL, PAL_RF_ERR_RATE_TBL, PAL_RF_CONFUSION_TBL) with overview ;


SELECT * FROM PAL_RF_MODEL_TBL;
SELECT * FROM PAL_RF_VAR_IMP_TBL;
SELECT * FROM PAL_RF_ERR_RATE_TBL;
SELECT * FROM PAL_RF_CONFUSION_TBL;

--PAL_RF_DATA_TBL