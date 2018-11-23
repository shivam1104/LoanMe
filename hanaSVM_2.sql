SET SCHEMA PRGOEL; 

DROP TYPE PAL_SVM_TRAINING_T;
CREATE TYPE PAL_SVM_TRAINING_T AS TABLE ( 
	id BIGINT ,
loan_status SMALLINT ,
loan_amnt INTEGER ,
funded_amnt INTEGER ,
funded_amnt_inv DECIMAL(17,7) ,
term TINYINT ,
int_rate DECIMAL(7,2) ,
installment DECIMAL(10,3) ,
grade TINYINT ,
sub_grade TINYINT ,
emp_length DECIMAL(20,7) ,
annual_inc DECIMAL(15,7) ,
issue_d NVARCHAR(6), 
zip_code SMALLINT ,
dti DECIMAL(7,2) ,
delinq_2yrs SMALLINT ,
earliest_cr_line NVARCHAR(6), 
inq_last_6mths SMALLINT ,
mths_since_last_delinq TINYINT ,
mths_since_last_record TINYINT ,
open_acc TINYINT ,
pub_rec SMALLINT ,
revol_bal INTEGER ,
revol_util DECIMAL(7,2) ,
total_acc TINYINT ,
out_prncp SMALLINT ,
out_prncp_inv SMALLINT ,
total_rec_int DECIMAL(13,7) ,
last_pymnt_d NVARCHAR(6), 
next_pymnt_d NVARCHAR(5), 
last_credit_pull_d NVARCHAR(6) ,
pub_rec_bankruptcies SMALLINT ,
monthly_inc DECIMAL(13,7) ,
column2 DECIMAL(8,2) ,
home_ownership_mortgage SMALLINT ,
home_ownership_none SMALLINT ,
home_ownership_other SMALLINT ,
home_ownership_own SMALLINT ,
home_ownership_rent SMALLINT ,
verification_status_not_verified SMALLINT ,
verification_status_source_verified SMALLINT ,
verification_status_verified SMALLINT ,
purpose_car SMALLINT ,
purpose_credit_card SMALLINT ,
purpose_debt_consolidation SMALLINT ,
purpose_educational SMALLINT ,
purpose_home_improvement SMALLINT ,
purpose_house SMALLINT ,
purpose_major_purchase SMALLINT ,
purpose_medical SMALLINT ,
purpose_moving SMALLINT ,
purpose_other SMALLINT ,
purpose_renewable_energy SMALLINT ,
purpose_small_business SMALLINT ,
purpose_vacation SMALLINT ,
purpose_wedding SMALLINT ,
addr_state_ak SMALLINT ,
addr_state_al SMALLINT ,
addr_state_ar SMALLINT ,
addr_state_az SMALLINT ,
addr_state_ca SMALLINT ,
addr_state_co SMALLINT ,
addr_state_ct SMALLINT ,
addr_state_dc SMALLINT ,
addr_state_de SMALLINT ,
addr_state_fl SMALLINT ,
addr_state_ga SMALLINT ,
addr_state_hi SMALLINT ,
addr_state_ia SMALLINT ,
addr_state_id SMALLINT ,
addr_state_il SMALLINT ,
addr_state_in SMALLINT ,
addr_state_ks SMALLINT ,
addr_state_ky SMALLINT ,
addr_state_la SMALLINT ,
addr_state_ma SMALLINT ,
addr_state_md SMALLINT ,
addr_state_me SMALLINT ,
addr_state_mi SMALLINT ,
addr_state_mn SMALLINT ,
addr_state_mo SMALLINT ,
addr_state_ms SMALLINT ,
addr_state_mt SMALLINT ,
addr_state_nc SMALLINT ,
addr_state_ne SMALLINT ,
addr_state_nh SMALLINT ,
addr_state_nj SMALLINT ,
addr_state_nm SMALLINT ,
addr_state_nv SMALLINT ,
addr_state_ny SMALLINT ,
addr_state_oh SMALLINT ,
addr_state_ok SMALLINT ,
addr_state_or SMALLINT ,
addr_state_pa SMALLINT ,
addr_state_ri SMALLINT ,
addr_state_sc SMALLINT ,
addr_state_sd SMALLINT ,
addr_state_tn SMALLINT ,
addr_state_tx SMALLINT ,
addr_state_ut SMALLINT ,
addr_state_va SMALLINT ,
addr_state_vt SMALLINT ,
addr_state_wa SMALLINT ,
addr_state_wi SMALLINT ,
addr_state_wv SMALLINT ,
addr_state_wy SMALLINT ,
annual_1 DECIMAL(10,4) ,
column3 DECIMAL(10,4) 


);

DROP TYPE PAL_CONTROL_T;
CREATE TYPE PAL_CONTROL_T AS TABLE( 
	NAME VARCHAR(50), 
	INTARGS INTEGER, 
	DOUBLEARGS DOUBLE, 
	STRINGARGS VARCHAR(100)
);

DROP TYPE PAL_SVM_MODEL_T;
CREATE TYPE PAL_SVM_MODEL_T AS TABLE( ID VARCHAR(50), MODEL VARCHAR(5000));

DROP TABLE PAL_SVM_PDATA_TBL;
CREATE TABLE PAL_SVM_PDATA_TBL("POSITION" INT, "SCHEMA_NAME" NVARCHAR(256), "TYPE_NAME" NVARCHAR(256), "PARAMETER_TYPE" VARCHAR(7));
INSERT INTO PAL_SVM_PDATA_TBL VALUES (1,'PRGOEL','PAL_SVM_TRAINING_T','IN');
INSERT INTO PAL_SVM_PDATA_TBL VALUES (2,'PRGOEL','PAL_CONTROL_T','IN');
INSERT INTO PAL_SVM_PDATA_TBL VALUES (3,'PRGOEL','PAL_SVM_MODEL_T','OUT');

CALL SYS.AFLLANG_WRAPPER_PROCEDURE_DROP('PRGOEL','PAL_SVM_TRAIN');

CALL SYS.AFLLANG_WRAPPER_PROCEDURE_CREATE('AFLPAL','SVMTRAIN','PRGOEL','PAL_SVM_TRAIN',PAL_SVM_PDATA_TBL);


DROP TABLE PAL_SVM_TRAINING_TBL;
CREATE COLUMN TABLE PAL_SVM_TRAINING_TBL LIKE PAL_SVM_TRAINING_T;

DROP TABLE #PAL_CONTROL_TBL;
CREATE LOCAL TEMPORARY COLUMN TABLE #PAL_CONTROL_TBL LIKE PAL_CONTROL_T;

DROP TABLE PAL_SVM_MODEL_TBL_EX1;
CREATE COLUMN TABLE PAL_SVM_MODEL_TBL_EX1 LIKE PAL_SVM_MODEL_T;


insert into PAL_SVM_TRAINING_TBL
select * from "PRGOEL"."TBL_INPUT_DAT";

INSERT INTO #PAL_CONTROL_TBL VALUES('THREAD_NUMBER',8,null,null);
INSERT INTO #PAL_CONTROL_TBL VALUES('KERNEL_TYPE',2,null,null);
INSERT INTO #PAL_CONTROL_TBL VALUES('TYPE',1,null,null);

CALL PRGOEL.PAL_SVM_TRAIN(PAL_SVM_TRAINING_TBL,#PAL_CONTROL_TBL,PAL_SVM_MODEL_TBL_EX1) WITH OVERVIEW;


SELECT * FROM PAL_SVM_MODEL_TBL_EX1;