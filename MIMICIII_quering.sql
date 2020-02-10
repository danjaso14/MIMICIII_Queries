-- Your submission should be a mix of simple queries, queries for aggregate
-- information, string queries, GROUP BY queries for aggregate information on
-- groups, and queries selecting information across more than one table (joins). At
-- least 4 of the queries should involve more than one table. 
-- At least 2 queries should
-- involve “GROUP BY”. Examples using the E. coli database are below.
-- Your set of queries should include at least one use (examples below) of each of the following
-- ORDER BY, SUBSTR, LENGTH, UPPER, LIKE, INNER JOIN, DISTINCT, COUNT, AVG



-- 1) Distribution of patient's gender
select gender, count(gender) as gender_nums
from patients
group by gender;

-- Output:
			-- gender	gender_nums
			-- M	26121
			-- F	20399

-- 2) find first_careunit thta contain ICU (limit to 10 so the output is short)
SELECT *
FROM icustays
WHERE first_careunit LIKE '%ICU%'
limit 10;

-- Output:

			-- row_id	subject_id	hadm_id	icustay_id	dbsource	first_careunit	last_careunit	first_wardid	last_wardid	intime	outtime	los
			-- 365	268	110404	280836	carevue	MICU	MICU	52	52	2198-02-14 23:27:38	2198-02-18 05:26:11	3.249
			-- 366	269	106296	206613	carevue	MICU	MICU	52	52	2170-11-05 11:05:29	2170-11-08 17:46:57	3.2788
			-- 368	271	173727	249196	carevue	MICU	SICU	52	23	2120-08-07 23:12:42	2120-08-10 00:39:04	2.06
			-- 370	273	158689	241507	carevue	MICU	MICU	52	52	2141-04-19 06:12:05	2141-04-20 17:52:11	1.4862
			-- 371	274	130546	254851	carevue	MICU	MICU	12	12	2114-06-28 22:28:44	2114-07-07 18:01:16	8.8143
			-- 374	277	171601	272866	carevue	NICU	NICU	56	56	2132-10-21 21:11:46	2132-10-22 14:44:48	0.7313
			-- 375	279	192224	204407	carevue	MICU	MICU	15	15	2164-06-14 21:18:27	2164-06-18 22:53:12	4.0658
			-- 376	280	123506	247496	carevue	NICU	NICU	56	56	2155-12-08 18:22:09	2155-12-22 17:10:45	13.9504
			-- 377	281	111199	257572	carevue	MICU	MICU	52	52	2101-10-18 04:45:22	2101-10-25 22:29:25	7.7389
			-- 378	282	119013	293262	carevue	TSICU	TSICU	14	14	2175-02-02 17:01:10	2175-02-03 13:27:58	0.8519



-- 3) Find the tiem of patients hosptialize time, corresponding to their death time.
-- (looking first to partients with longest time hospitalize).
SELECT subject_id, admittime, deathtime, (deathtime - admittime) AS hospitalize_time 
FROM admissions
WHERE deathtime IS NOT NULL
order by hospitalize_time desc;

-- Output:

			-- subject_id	admittime	deathtime	hospitalize_time
			-- 93321	2128-03-24 23:01:00	2128-10-17 09:14:00	206 days, 10:13:00
			-- 6702	2129-04-18 14:51:00	2129-10-27 01:00:00	191 days, 10:09:00
			-- 17081	2138-03-11 16:30:00	2138-08-25 14:16:00	166 days, 21:46:00
			-- 3250	2169-12-04 18:13:00	2170-05-18 03:00:00	164 days, 8:47:00
			-- 26492	2166-11-20 21:35:00	2167-04-15 18:10:00	145 days, 20:35:00
			-- 28972	2127-08-12 17:11:00	2127-12-28 14:35:00	137 days, 21:24:00
			-- 66508	2165-02-25 11:40:00	2165-07-06 20:27:00	131 days, 8:47:00
			-- 14237	2174-12-26 16:39:00	2175-05-04 17:30:00	129 days, 0:51:00
			-- 27766	2167-01-08 10:44:00	2167-05-15 11:00:00	127 days, 0:16:00
			-- 42904	2174-04-22 07:15:00	2174-08-23 10:19:00	123 days, 3:04:00
			-- 517	2158-09-09 15:48:00	2159-01-04 20:09:00	117 days, 4:21:00
			-- 20779	2149-03-06 19:48:00	2149-06-22 19:17:00	107 days, 23:29:00
			-- 98606	2128-01-14 11:33:00	2128-04-30 18:30:00	107 days, 6:57:00
			-- 30202	2125-08-04 18:16:00	2125-11-19 14:14:00	106 days, 19:58:00
			-- 51551	2151-02-03 10:25:00	2151-05-20 15:21:00	106 days, 4:56:00
			-- 27427	2150-11-03 22:05:00	2151-02-17 12:00:00	105 days, 13:55:00
			-- 14432	2168-08-08 15:30:00	2168-11-19 12:00:00	102 days, 20:30:00
			-- 11091	2101-06-07 13:57:00	2101-09-18 07:20:00	102 days, 17:23:00
			-- 43563	2101-01-19 04:07:00	2101-04-29 15:50:00	100 days, 11:43:00
			-- 7391	2201-12-08 00:44:00	2202-03-18 07:40:00	100 days, 6:56:00
			-- 76736	2167-12-19 16:02:00	2168-03-26 13:30:00	97 days, 21:28:00
			-- 14249	2157-01-01 21:22:00	2157-04-09 03:47:00	97 days, 6:25:00
			-- 66745	2145-09-01 22:20:00	2145-12-07 10:35:00	96 days, 12:15:00
			-- 72670	2116-06-08 09:39:00	2116-09-11 05:44:00	94 days, 20:05:00
			-- 2743	2128-12-16 05:48:00	2129-03-17 06:01:00	91 days, 0:13:00
			-- 85699	2153-01-31 10:55:00	2153-04-29 13:08:00	88 days, 2:13:00
			-- 834	2166-06-17 03:00:00	2166-09-12 11:30:00	87 days, 8:30:00
			-- 81480	2180-10-22 15:59:00	2181-01-18 00:01:00	87 days, 8:02:00
			-- 14150	2194-04-24 16:50:00	2194-07-20 14:30:00	86 days, 21:40:00
			-- 49930	2162-08-04 08:00:00	2162-10-29 12:00:00	86 days, 4:00:00
			-- 1113	2106-12-07 17:19:00	2107-03-03 16:19:00	85 days, 23:00:00
			-- 16949	2168-02-23 17:03:00	2168-05-17 13:32:00	83 days, 20:29:00
			-- 95929	2190-03-02 18:00:00	2190-05-24 05:23:00	82 days, 11:23:00
			-- 60762	2135-06-30 03:02:00	2135-09-18 10:20:00	80 days, 7:18:00
			-- 28933	2170-05-19 21:46:00	2170-08-07 16:08:00	79 days, 18:22:00
			-- 26645	2122-04-16 07:15:00	2122-07-04 06:38:00	78 days, 23:23:00
			-- 91333	2176-02-27 17:39:00	2176-05-15 18:45:00	78 days, 1:06:00
			-- 188	2161-11-01 17:48:00	2162-01-17 05:50:00	76 days, 12:02:00
			-- 26205	2133-03-06 12:53:00	2133-05-21 14:15:00	76 days, 1:22:00
			-- 408	2188-10-27 21:25:00	2189-01-11 20:19:00	75 days, 22:54:00
			-- 16565	2137-04-17 00:37:00	2137-07-01 12:45:00	75 days, 12:08:00
			-- 74857	2112-08-17 16:16:00	2112-10-30 12:38:00	73 days, 20:22:00
			-- 4894	2130-06-06 21:02:00	2130-08-18 13:14:00	72 days, 16:12:00
			-- 60508	2125-10-10 08:00:00	2125-12-21 11:24:00	72 days, 3:24:00
			-- 14590	2165-07-16 21:46:00	2165-09-26 05:32:00	71 days, 7:46:00
			-- 6789	2196-07-15 11:31:00	2196-09-24 12:08:00	71 days, 0:37:00
			-- 13351	2162-02-04 03:59:00	2162-04-15 08:25:00	70 days, 4:26:00
			-- 8406	2149-06-29 01:22:00	2149-09-07 01:18:00	69 days, 23:56:00
			-- 49925	2152-06-14 17:26:00	2152-08-23 13:20:00	69 days, 19:54:00
			-- 27315	2169-01-08 17:35:00	2169-03-19 09:57:00	69 days, 16:22:00
			--- MORE OUTPUT------

-- 4) Finding overall Hispanic/Latino Admission Locations, what was their corresponding
-- admission type and the instances of each one.
select ADMISSION_LOCATION , ADMISSION_TYPE ,ETHNICITY, COUNT(ETHNICITY) as ethn_dist
from  admissions
where ETHNICITY = 'HISPANIC OR LATINO' or ETHNICITY  ='HISPANIC/LATINO - PUERTO RICAN'
group by ETHNICITY, ADMISSION_LOCATION, ADMISSION_TYPE
order by ethn_dist desc;


-- Output:

			-- admission_location	admission_type	ethnicity	ethn_dist
			-- EMERGENCY ROOM ADMIT	EMERGENCY	HISPANIC OR LATINO	715
			-- CLINIC REFERRAL/PREMATURE	EMERGENCY	HISPANIC OR LATINO	289
			-- PHYS REFERRAL/NORMAL DELI	NEWBORN	HISPANIC OR LATINO	255
			-- PHYS REFERRAL/NORMAL DELI	ELECTIVE	HISPANIC OR LATINO	151
			-- TRANSFER FROM HOSP/EXTRAM	EMERGENCY	HISPANIC OR LATINO	101
			-- CLINIC REFERRAL/PREMATURE	NEWBORN	HISPANIC OR LATINO	98
			-- EMERGENCY ROOM ADMIT	EMERGENCY	HISPANIC/LATINO - PUERTO RICAN	92
			-- CLINIC REFERRAL/PREMATURE	EMERGENCY	HISPANIC/LATINO - PUERTO RICAN	84
			-- PHYS REFERRAL/NORMAL DELI	EMERGENCY	HISPANIC OR LATINO	34
			-- PHYS REFERRAL/NORMAL DELI	ELECTIVE	HISPANIC/LATINO - PUERTO RICAN	22
			-- TRANSFER FROM HOSP/EXTRAM	EMERGENCY	HISPANIC/LATINO - PUERTO RICAN	20
			-- TRANSFER FROM HOSP/EXTRAM	URGENT	HISPANIC OR LATINO	16
			-- ** INFO NOT AVAILABLE **	NEWBORN	HISPANIC OR LATINO	10
			-- PHYS REFERRAL/NORMAL DELI	URGENT	HISPANIC OR LATINO	9
			-- HMO REFERRAL/SICK	NEWBORN	HISPANIC OR LATINO	8
			-- PHYS REFERRAL/NORMAL DELI	EMERGENCY	HISPANIC/LATINO - PUERTO RICAN	5
			-- TRANSFER FROM SKILLED NUR	EMERGENCY	HISPANIC OR LATINO	4
			-- PHYS REFERRAL/NORMAL DELI	NEWBORN	HISPANIC/LATINO - PUERTO RICAN	3
			-- ** INFO NOT AVAILABLE **	NEWBORN	HISPANIC/LATINO - PUERTO RICAN	2
			-- TRANSFER FROM HOSP/EXTRAM	URGENT	HISPANIC/LATINO - PUERTO RICAN	1
			-- TRANSFER FROM SKILLED NUR	URGENT	HISPANIC OR LATINO	1
			-- TRANSFER FROM OTHER HEALT	EMERGENCY	HISPANIC OR LATINO	1
			-- CLINIC REFERRAL/PREMATURE	NEWBORN	HISPANIC/LATINO - PUERTO RICAN	1
			-- TRANSFER FROM HOSP/EXTRAM	NEWBORN	HISPANIC OR LATINO	1
			-- PHYS REFERRAL/NORMAL DELI	URGENT	HISPANIC/LATINO - PUERTO RICAN	1
			-- CLINIC REFERRAL/PREMATURE	URGENT	HISPANIC OR LATINO	1
			-- TRANSFER FROM SKILLED NUR	EMERGENCY	HISPANIC/LATINO - PUERTO RICAN	1
			-- TRANSFER FROM SKILLED NUR	ELECTIVE	HISPANIC OR LATINO	1
			-- CLINIC REFERRAL/PREMATURE	ELECTIVE	HISPANIC OR LATINO	1


--  5) Finding the overall distribution of Gender, Ethnicity, and Martial status 
-- instances per each group
select   patients_info.GENDER , admission_info.ETHNICITY , admission_info.MARITAL_STATUS, count(admission_info.MARITAL_STATUS)  as Martial_instances
from  patients as patients_info
left join admissions as admission_info
on patients_info.SUBJECT_ID  = admission_info.SUBJECT_ID 
group by patients_info.GENDER, admission_info.ETHNICITY, admission_info.MARITAL_STATUS
order by Martial_instances desc;

-- Output:


			-- gender	ethnicity	marital_status	martial_instances
			-- M	WHITE	MARRIED	11994
			-- F	WHITE	MARRIED	6090
			-- M	WHITE	SINGLE	5147
			-- F	WHITE	WIDOWED	4093
			-- F	WHITE	SINGLE	3532
			-- M	WHITE	WIDOWED	1498
			-- M	UNKNOWN/NOT SPECIFIED	MARRIED	1268
			-- F	BLACK/AFRICAN AMERICAN	SINGLE	1238
			-- F	WHITE	DIVORCED	1221
			-- M	WHITE	DIVORCED	1156
			-- M	BLACK/AFRICAN AMERICAN	SINGLE	859
			-- M	BLACK/AFRICAN AMERICAN	MARRIED	818
			-- F	UNKNOWN/NOT SPECIFIED	MARRIED	579
			-- F	BLACK/AFRICAN AMERICAN	WIDOWED	494
			-- F	BLACK/AFRICAN AMERICAN	MARRIED	483
			-- M	OTHER	MARRIED	376
			-- M	HISPANIC OR LATINO	SINGLE	369
			-- M	UNKNOWN/NOT SPECIFIED	SINGLE	364
			-- F	UNKNOWN/NOT SPECIFIED	WIDOWED	345
			-- M	ASIAN	MARRIED	335
			-- M	HISPANIC OR LATINO	MARRIED	331
			-- F	BLACK/AFRICAN AMERICAN	DIVORCED	255
			-- F	UNKNOWN/NOT SPECIFIED	SINGLE	229
			-- F	HISPANIC OR LATINO	SINGLE	214
			-- M	UNABLE TO OBTAIN	MARRIED	200
			-- M	OTHER	SINGLE	188
			-- M	PATIENT DECLINED TO ANSWER	MARRIED	178
			-- F	ASIAN	MARRIED	172
			-- F	OTHER	MARRIED	166
			-- F	HISPANIC OR LATINO	MARRIED	161
			-- F	WHITE	SEPARATED	132
			-- M	WHITE	SEPARATED	125
			-- M	UNKNOWN/NOT SPECIFIED	WIDOWED	120
			-- F	BLACK/AFRICAN AMERICAN	SEPARATED	117
			-- F	OTHER	SINGLE	117
			-- M	BLACK/AFRICAN AMERICAN	WIDOWED	115
			-- M	ASIAN - CHINESE	MARRIED	111
			-- M	BLACK/AFRICAN AMERICAN	DIVORCED	105
			-- M	ASIAN	SINGLE	95
			-- F	UNABLE TO OBTAIN	MARRIED	93
			-- F	ASIAN	SINGLE	93
			-- F	UNKNOWN/NOT SPECIFIED	DIVORCED	87
			-- M	UNKNOWN/NOT SPECIFIED	DIVORCED	81
			-- F	WHITE	UNKNOWN (DEFAULT)	80
			-- M	BLACK/AFRICAN AMERICAN	SEPARATED	79
			-- M	UNABLE TO OBTAIN	SINGLE	75
			-- F	OTHER	WIDOWED	74
			-- F	PATIENT DECLINED TO ANSWER	MARRIED	74
			-- F	HISPANIC OR LATINO	WIDOWED	71
			-- M	HISPANIC/LATINO - PUERTO RICAN	SINGLE	69
			-- M	WHITE	UNKNOWN (DEFAULT)	69
			-- F	UNKNOWN/NOT SPECIFIED	UNKNOWN (DEFAULT)	66
			-- M	UNKNOWN/NOT SPECIFIED	UNKNOWN (DEFAULT)	65
			-- F	ASIAN - CHINESE	MARRIED	64
			-- M	HISPANIC OR LATINO	DIVORCED	58
			-- M	BLACK/CAPE VERDEAN	MARRIED	55
			-- M	PATIENT DECLINED TO ANSWER	SINGLE	54
			-- M	HISPANIC/LATINO - PUERTO RICAN	MARRIED	54
			-- F	UNABLE TO OBTAIN	SINGLE	53



-- from most common to least one.
-- select ICD9_CODE, count(distinct SUBJECT_ID) as diseases_diag_dist
-- from diagnoses_icd 
-- group by ICD9_CODE 
-- order by count(distinct SUBJECT_ID) desc;

-- Short title description diagnosis per icd9_code 
-- select t1.ICD9_CODE , t2.SHORT_TITLE, count(distinct t1.SUBJECT_ID) as counter
-- from diagnoses_icd t1 
-- join d_icd_diagnoses t2 using (ICD9_CODE)
-- group by t1.ICD9_CODE, t2.SHORT_TITLE 
-- order by count(distinct t1.SUBJECT_ID) desc;





-- 6) Top 10 diseases diagnosed accross MIMIC iii database 
select t1.ICD9_CODE , t2.SHORT_TITLE, count(distinct t1.SUBJECT_ID) as diseases_diag_dist
from diagnoses_icd t1 
join d_icd_diagnoses t2 using (ICD9_CODE)
group by t1.ICD9_CODE, t2.SHORT_TITLE 
order by diseases_diag_dist desc
limit 10;

-- Output:

			-- icd9_code	short_title	diseases_diag_dist
			-- 4019	Hypertension NOS	17613
			-- 41401	Crnry athrscl natve vssl	10775
			-- 42731	Atrial fibrillation	10271
			-- 4280	CHF NOS	9843
			-- 5849	Acute kidney failure NOS	7687
			-- 2724	Hyperlipidemia NEC/NOS	7465
			-- 25000	DMII wo cmp nt st uncntr	7370
			-- 51881	Acute respiratry failure	6719
			-- 5990	Urin tract infection NOS	5779
			-- V053	Need prphyl vc vrl hepat	5776


-- 7) Top 5 drug treatment for Hypertension NOS (with ICD9_CODE 4019)
select t2.ICD9_CODE , t1.DRUG, count(drug) as inst
from prescriptions as t1
inner join diagnoses_icd as t2 using (subject_id)
where ICD9_CODE = '4019'
group by t2.ICD9_CODE , t1.DRUG
order by inst desc 
limit 5;

-- Output:


			-- icd9_code	drug	inst
			-- icd9_code	drug	inst
			-- 4019	Potassium Chloride	136709
			-- 4019	Insulin	123711
			-- 4019	Furosemide	101341
			-- 4019	0.9% Sodium Chloride	91875
			-- 4019	D5W	91660

-- select t2.ICD9_CODE, t1.hosptialize_time
-- from 
-- (SELECT subject_id, admittime, deathtime, (deathtime - admittime) AS hosptialize_time
-- FROM admissions
-- WHERE deathtime IS NOT NULL
-- order by hosptialize_time desc) as t1 
-- INNER JOIN diagnoses_icd as t2 using (subject_id)
-- where ICD9_CODE = '4019'
-- limit 10;


-- select t2.ICD9_CODE,   MIN( t1.hosptialize_time) as Minimum_Patient_Time, MAX( t1.hosptialize_time) as Maximum_Patient_Time, AVG(t1.hosptialize_time) as Average_Patient_Time
-- from 
-- (SELECT subject_id, admittime, deathtime, (deathtime - admittime) AS hosptialize_time
-- FROM admissions
-- WHERE deathtime IS NOT NULL
-- order by hosptialize_time desc) as t1 
-- INNER JOIN diagnoses_icd as t2 using (subject_id)
-- where ICD9_CODE = '4019'
-- GROUP BY t2.ICD9_CODE;

-- 8)  Getting the miniumun, maximum and average patients that had op 10 diseases diagnosed accross MIMIC iii database 
select t2.ICD9_CODE,  MIN( t1.hosptialize_time) as Minimum_Patient_Time, MAX( t1.hosptialize_time) as Maximum_Patient_Time, AVG(t1.hosptialize_time) as Average_Patient_Time
from 
(SELECT subject_id, admittime, deathtime, (deathtime - admittime) AS hosptialize_time
FROM admissions
WHERE deathtime IS NOT NULL
order by hosptialize_time desc) as t1 
INNER JOIN diagnoses_icd as t2 using (subject_id)
WHERE ICD9_CODE IN ('4019', '41401', '42731', '4280', '5849', '2724', '2500', '51881', '5990', 'V053')
GROUP BY t2.ICD9_CODE;


-- Output:
			-- icd9_code	minimum_patient_time	maximum_patient_time	average_patient_time
			-- 2724	-30 days, 3:17:00	206 days, 10:13:00	9 days, 8:11:43.676939
			-- 5849	-1 day, 5:33:00	206 days, 10:13:00	11 days, 14:54:32.163695
			-- 42731	-3 days, 2:16:00	191 days, 10:09:00	11 days, 8:21:40.086674
			-- 51881	-29 days, 22:08:00	206 days, 10:13:00	12 days, 0:53:46.858209
			-- 41401	-1 day, 9:05:00	106 days, 19:58:00	9 days, 16:31:49.915966
			-- 25000	-3 days, 2:16:00	145 days, 20:35:00	10 days, 10:12:41.106870
			-- V053	117 days, 4:21:00	117 days, 4:21:00	117 days, 4:21:00
			-- 4280	-2 days, 16:18:00	191 days, 10:09:00	11 days, 3:19:45.046154
			-- 4019	-30 days, 3:17:00	191 days, 10:09:00	9 days, 10:04:13.716690
			-- 5990	-1 day, 22:27:00	191 days, 10:09:00	14 days, 14:46:52.264303


-- 9) Showing patients who stayed the longest (top 50) that were diagnosed with
--   Hypertension NOS (with ICD9_CODE 4019), displaying what drug they took.
select t2.ICD9_CODE, t1.hosptialize_time, t3.drug
from 
(SELECT subject_id, admittime, deathtime, (deathtime - admittime) AS hosptialize_time
FROM admissions
WHERE deathtime IS NOT NULL
order by hosptialize_time desc) as t1 
INNER JOIN diagnoses_icd as t2 using (subject_id)
INNER JOIN prescriptions as t3 using (subject_id)
where ICD9_CODE = '4019'
order by hosptialize_time desc
limit 50;

-- Output:

			-- icd9_code	hosptialize_time	drug
			-- 4019	191 days, 10:09:00	Potassium Chloride
			-- 4019	191 days, 10:09:00	Warfarin
			-- 4019	191 days, 10:09:00	Warfarin
			-- 4019	191 days, 10:09:00	Warfarin
			-- 4019	191 days, 10:09:00	SW
			-- 4019	191 days, 10:09:00	Potassium Chloride
			-- 4019	191 days, 10:09:00	Gentamicin
			-- 4019	191 days, 10:09:00	Isotonic Sodium Chloride
			-- 4019	191 days, 10:09:00	Warfarin
			-- 4019	191 days, 10:09:00	Warfarin
			-- 4019	191 days, 10:09:00	Iso-Osmotic Dextrose
			-- 4019	191 days, 10:09:00	Piperacillin-Tazobactam Na
			-- 4019	191 days, 10:09:00	Lansoprazole Oral Disintegrating Tab
			-- 4019	191 days, 10:09:00	Heparin Flush PICC (100 units/ml)
			-- 4019	191 days, 10:09:00	Warfarin
			-- 4019	191 days, 10:09:00	Acetaminophen
			-- 4019	191 days, 10:09:00	Erythromycin 0.5% Ophth Oint
			-- 4019	191 days, 10:09:00	Atorvastatin
			-- 4019	191 days, 10:09:00	Albuterol 0.083% Neb Soln
			-- 4019	191 days, 10:09:00	Bisacodyl
			-- 4019	191 days, 10:09:00	Sodium Chloride 0.9% Flush
			-- 4019	191 days, 10:09:00	Warfarin
			-- 4019	191 days, 10:09:00	Heparin Sodium
			-- 4019	191 days, 10:09:00	D5W
			-- 4019	191 days, 10:09:00	Warfarin
			-- 4019	191 days, 10:09:00	Lidocaine Jelly 2% (Urojet)
			-- 4019	191 days, 10:09:00	D5W
			-- 4019	191 days, 10:09:00	Heparin Sodium
			-- 4019	191 days, 10:09:00	Iso-Osmotic Dextrose
			-- 4019	191 days, 10:09:00	Piperacillin-Tazobactam Na
			-- 4019	191 days, 10:09:00	Heparin Sodium
			-- 4019	191 days, 10:09:00	D5W
			-- 4019	191 days, 10:09:00	Heparin Flush PICC (100 units/ml)
			-- 4019	191 days, 10:09:00	Gentamicin
			-- 4019	191 days, 10:09:00	Isotonic Sodium Chloride
			-- 4019	191 days, 10:09:00	Heparin Sodium
			-- 4019	191 days, 10:09:00	D5W
			-- 4019	191 days, 10:09:00	NS
			-- 4019	191 days, 10:09:00	MetRONIDAZOLE (FLagyl)
			-- 4019	191 days, 10:09:00	Metoprolol
			-- 4019	191 days, 10:09:00	Vial
			-- 4019	191 days, 10:09:00	Pantoprazole Sodium
			-- 4019	191 days, 10:09:00	Heparin Sodium
			-- 4019	191 days, 10:09:00	D5W
			-- 4019	191 days, 10:09:00	Potassium Chloride
			-- 4019	191 days, 10:09:00	D5W
			-- 4019	191 days, 10:09:00	Heparin Sodium
			-- 4019	191 days, 10:09:00	NS
			-- 4019	191 days, 10:09:00	Acetaminophen (Liquid)
			-- 4019	191 days, 10:09:00	D5W




-- 10) Form previous query, get the top 50 durgs this patients received (top 50 drugs administer).
select t4.drug, count(drug) as drug_inst
from 
(select t2.ICD9_CODE, t1.hosptialize_time, t3.drug
from 
(SELECT subject_id, admittime, deathtime, (deathtime - admittime) AS hosptialize_time
FROM admissions
WHERE deathtime IS NOT NULL
order by hosptialize_time desc) as t1 
INNER JOIN diagnoses_icd as t2 using (subject_id)
INNER JOIN prescriptions as t3 using (subject_id)
where ICD9_CODE = '4019'
order by hosptialize_time desc) as t4
group by t4.drug
order by drug_inst desc
limit 50;

-- Output:

			-- drug	drug_inst
			-- Potassium Chloride	22355
			-- D5W	22033
			-- NS	21996
			-- Furosemide	19267
			-- Insulin	19033
			-- 0.9% Sodium Chloride	18371
			-- Iso-Osmotic Dextrose	13046
			-- 5% Dextrose	12780
			-- Magnesium Sulfate	10817
			-- Morphine Sulfate	9970
			-- SW	9640
			-- Metoprolol	9476
			-- Sodium Chloride 0.9% Flush	8682
			-- Acetaminophen	7638
			-- Calcium Gluconate	7087
			-- Vancomycin	6820
			-- Lorazepam	6771
			-- Metoprolol Tartrate	6198
			-- Heparin	6004
			-- Fentanyl Citrate	5009
			-- LR	4857
			-- Bisacodyl	4108
			-- Sodium Bicarbonate	4084
			-- Docusate Sodium	3968
			-- Pantoprazole	3929
			-- Heparin Sodium	3794
			-- Albuterol 0.083% Neb Soln	3769
			-- Warfarin	3719
			-- Propofol	3717
			-- Vial	3685
			-- Senna	3466
			-- Diltiazem	3376
			-- HYDROmorphone (Dilaudid)	3297
			-- Bag	3290
			-- Ipratropium Bromide Neb	3230
			-- 0.9% Sodium Chloride (Mini Bag Plus)	3076
			-- Aspirin	3052
			-- Vancomycin HCl	2976
			-- Levofloxacin	2934
			-- PredniSONE	2683
			-- Pantoprazole Sodium	2592
			-- Midazolam	2530
			-- Dextrose 50%	2451
			-- Haloperidol	2398
			-- Potassium Phosphate	2369
			-- Amiodarone	2284
			-- Neutra-Phos	2250
			-- D5 1/2NS	2247
			-- Ondansetron	2243
			-- Norepinephrine	2203