drop  DATABASE if exists hospital_db;
CREATE DATABASE hospital_db;

USE hospital_db;

DROP TABLE IF EXISTS STAFF;
CREATE TABLE STAFF(
	emp_number 	CHAR(6) NOT NULL PRIMARY KEY,
    `name` VARCHAR(50),
    gender CHAR(1),
    teleno CHAR(10),
    address VARCHAR(100)
);

INSERT INTO STAFF VALUES
("DOC001","Kavindu Dias","M","0771234568","No2/14,imaduwa,galle"),
("DOC002","Kavindu Maleesha","M","0773457890","kithulampitiya,galle"),
("DOC003","Nimsara Dias","M","0771234578","galle road,matara"),
("DOC004","Navod viduranga","M","0712234578","No 12,galle road,matara"),
("SUR001","PIUMI Imalsha","F","0771267568","No 128,apeksha road,maharagama"),
("SUR002","Navindu Jithnuga","M","0741234568","galle road,dehiwala"),
("SUR003","Pamith Vikum","M","0751234568","galle road,kaluthara"),
("NUR001","Chamod Anjana","M","0711234568","No20, galle road,hikkaduwa"),
("NUR002","Tharushi silva","F","0752234568","No 50,galle road,matara"),
("NUR003","Tharushi amarathunga","F","0752234778","No 12,galle road,matara"),
("HDD001","Raveesha Hasaranga","M","0741234768","No 2,galle road,dehiwala"),
("HDD002","Hasaranga Vikum","M","0723234768","No 2,galle road,dehiwala");

SELECT * FROM STAFF;

DROP TABLE IF EXISTS DOCTOR;
CREATE TABLE DOCTOR(
	emp_number CHAR(6) NOT NULL PRIMARY KEY,
    speciality VARCHAR(100),
    salary FLOAT,
    FOREIGN KEY (emp_number) REFERENCES STAFF(emp_number) ON DELETE CASCADE
);

INSERT INTO DOCTOR VALUES
("DOC001","Eye and ears",80800.00),
("DOC002","Surgery",90000.00),
("DOC003","Orthopedics",78000.00);

SELECT * FROM DOCTOR;

DROP TABLE IF EXISTS SURGEON;
CREATE TABLE SURGEON(
	emp_number CHAR(6) NOT NULL PRIMARY KEY,
    speciality VARCHAR(100),
    type_of_contract VARCHAR(20),
    length_of_contract INT,
    contract_amount float,
    FOREIGN KEY (emp_number) REFERENCES STAFF(emp_number) ON DELETE CASCADE
);

INSERT INTO SURGEON VALUES
("SUR001","Surgery","temp",1,150800.00),
("SUR002","Neurology","fulltime",2,150800.00),
("SUR003","Cardiology","fulltime",2,170800.00);

SELECT * FROM SURGEON;


DROP TABLE IF EXISTS NURSE;
CREATE TABLE NURSE(
	emp_number CHAR(6) NOT NULL PRIMARY KEY,
    salary FLOAT,
    grade VARCHAR(1),
    years_of_experience INT,
    surgery_skill_type VARCHAR(100),
	FOREIGN KEY (emp_number) REFERENCES STAFF(emp_number) ON DELETE CASCADE
);

INSERT INTO NURSE VALUES
("NUR001",65000,"1",10,"Preoperative Care"),
("NUR002",75000,"2",5,"Sterile Technique"),
("NUR003",72000,"1",8,"Emergency Response");

SELECT * FROM NURSE;

DROP TABLE IF EXISTS HDDOCTOR;
CREATE TABLE HDDOCTOR(
	emp_number CHAR(6) NOT NULL,
    hd_number CHAR(6) NOT NULL,
    speciality VARCHAR(100),
    salary FLOAT,
    PRIMARY KEY(emp_number,hd_number),
    FOREIGN KEY (emp_number) REFERENCES STAFF(emp_number) ON DELETE CASCADE
);

INSERT INTO HDDOCTOR VALUES
("HDD001","HDC111","Surgery",100900.00),
("HDD002","HDC112","Cardiology",110900.00);

SELECT * FROM HDDOCTOR;

DROP TABLE IF EXISTS PATIENT;
CREATE TABLE PATIENT(
	patient_id CHAR(6) NOT NULL PRIMARY KEY,
    patient_initials VARCHAR(10),
    patient_name VARCHAR(60),
    telephone VARCHAR(10),
    address VARCHAR(100),
    age INT,
    blood_type VARCHAR(3),
	allergies VARCHAR(100)
);

INSERT INTO PATIENT VALUES
("PAT001","I.W","Pulindu Gihan","0780123456","No1,hikkaduwa,baddegama",21,"AB+","Pollen allergy"),
("PAT002","P.G","Kalana sehara","0770143456","No45,hikkaduwa,baddegama",21,"AB-","Cool allergy"),
("PAT003","A.A","Chalana pamith","0780123445","No1,hikkaduwa,baddegama",21,"O+","Pollen allergy");

SELECT * FROM PATIENT;

DROP TABLE IF EXISTS LOCATION;
CREATE TABLE LOCATION(
	room_no CHAR(5) NOT NULL,
    bed_no CHAR(5) NOT NULL,
    nursing_unit CHAR(4),
    PRIMARY KEY(bed_no,room_no)
);

INSERT INTO LOCATION VALUES
("RO001","BD001","HQP1"),
("RO002","BD001","HQP2"),
("RO003","BD002","HQP2");

SELECT * FROM LOCATION;

DROP TABLE IF EXISTS PAT_LOCATION;
CREATE TABLE PAT_LOCATION(
    room_no CHAR(5) NOT NULL,
	bed_no CHAR(5) NOT NULL,
    patient_id CHAR(6),
    PRIMARY KEY(bed_no,room_no),
    Foreign KEY (patient_id) REFERENCES PATIENT(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (bed_no,room_no) REFERENCES LOCATION(bed_no,room_no) ON DELETE CASCADE
);


INSERT INTO PAT_LOCATION VALUES
("RO001","BD001","PAT002");

DROP TABLE IF EXISTS SURGERY;
CREATE TABLE SURGERY(
	surgery_id CHAR(6) NOT NULL PRIMARY KEY,
	patient_id CHAR(6) NOT NULL,
    surgery_name VARCHAR(100),
    room_no CHAR(5) NOT NULL,
    bed_no CHAR(5) NOT NULL,
    s_date DATE,
    s_time TIME,
    FOREIGN KEY (patient_id) REFERENCES PATIENT(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (bed_no,room_no) REFERENCES LOCATION(bed_no,room_no) ON DELETE CASCADE
);

INSERT INTO SURGERY(surgery_id,patient_id,surgery_name,room_no,bed_no,s_date,s_time) VALUES
("SRG001","PAT002","cardio vascular","RO003","BD002","2023-11-07","12:30:00");

SELECT * FROM SURGERY;

DROP TABLE IF EXISTS S_EMPLOYEES;
CREATE TABLE S_EMPLOYEES(
	 surgery_id CHAR(6) NOT NULL,
	 emp_number CHAR(6) NOT NULL,
     PRIMARY KEY (surgery_id,emp_number),
     FOREIGN KEY (emp_number) REFERENCES STAFF(emp_number) ON DELETE CASCADE,
     FOREIGN KEY (surgery_id) REFERENCES SURGERY(surgery_id) ON DELETE CASCADE
);

INSERT INTO S_EMPLOYEES VALUES
("SRG001","NUR001"),
("SRG001","NUR002");
SELECT * FROM S_EMPLOYEES;

DROP TABLE IF EXISTS MEDICATION;
CREATE TABLE MEDICATION(
	medication_id VARCHAR(6) NOT NULL PRIMARY KEY,
    m_name VARCHAR(30),
    qnt_available INT,
    expire_date DATE
);

UPDATE MEDICATION SET qnt_available= 300 WHERE medication_id = "MED001";

INSERT INTO MEDICATION VALUES
("MED001","Penicillins",100,"2028-03-07"),
("MED002","Carbapenems",180,"2026-04-09"),
("MED003","Corticosteroids",200,"2026-03-09"),
("MED00","Penicillins",100,"2023-09-20");

SELECT * FROM MEDICATION;

DROP TABLE IF EXISTS MEDICATION_ORDER;
CREATE TABLE MEDICATION_ORDER(
	order_id VARCHAR(6) NOT NULL,
	medication_id VARCHAR(6) NOT NULL,
    PRIMARY KEY(order_id,medication_id),
    patient_id CHAR(6) NOT NULL,
    quantity_orderded INT,
    cost FLOAT,
    FOREIGN KEY (patient_id) REFERENCES PATIENT(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (medication_id) REFERENCES MEDICATION(medication_id) ON DELETE CASCADE
);

INSERT INTO MEDICATION_ORDER VALUES
("ORD001","MED001","PAT001",10,5000),
("ORD002","MED003","PAT002",8,1000),
("ORD003","MED002","PAT001",12,6000);

SELECT * FROM MEDICATION_ORDER;

CREATE OR REPLACE VIEW PATIENTVIEW AS
SELECT p.patient_id, CONCAT(p.patient_initials," ",p.patient_name) AS patient_name, 
CONCAT(l.bed_no," ",l.room_no) AS location, s.surgery_name, s.s_date
FROM PATIENT p 
JOIN PAT_LOCATION l ON p.patient_id = l.patient_id
JOIN SURGERY s ON p.patient_id = s.patient_id;

select * from PATIENTVIEW;



DROP TABLE IF EXISTS MedInfo;
CREATE TABLE MedInfo(
MedName VARCHAR(100),
QuantityAvailable INT,
ExpirationDate DATE
);


DELIMITER //

CREATE TRIGGER INSERT_MEDiNFO
AFTER INSERT ON MEDICATION
FOR EACH ROW
BEGIN
	INSERT INTO MedInfo(MedName,QuantityAvailable,ExpirationDate)
    VALUES(NEW.m_name,NEW.qnt_available,NEW.expire_date);
END //
DELIMITER ;

Insert INTO MEDICATION VALUES
("MED006","AMOXCELINE",200,"2026-04-09");

select * FROM MedInfo;


DROP TRIGGER IF EXISTS UPDATE_MEDiNFO;
DELIMITER //

CREATE TRIGGER UPDATE_MEDiNFO
BEFORE UPDATE ON MEDICATION 
FOR EACH ROW
BEGIN
	IF (OLD.qnt_available != NEW.qnt_available) THEN
		UPDATE MedInfo
        SET QuantityAvailable = NEW.qnt_available
        WHERE MedName = NEW.m_name;
	ELSEIF (OLD.expire_date != NEW.expire_date) THEN
		UPDATE MedInfo
        SET ExpirationDate = NEW.expire_date
        WHERE MedName = NEW.m_name;
	END IF;
END //
DELIMITER ;

UPDATE MEDICATION SET qnt_available = 400 WHERE medication_id = "MED006";
UPDATE MEDICATION SET expire_date = "2025-11-06" WHERE medication_id = "MED006";

SELECT * FROM  MedInfo;


CREATE TRIGGER DELETE_MEDiNFO
AFTER DELETE ON MEDICATION
FOR EACH ROW
DELETE FROM MedInfo
WHERE MedName = OLD.m_name;

DELETE FROM MEDICATION WHERE m_name = "AMOXCELINE";
SELECT * FROM  MedInfo;


DROP PROCEDURE IF EXISTS COUNT_MEDICATION;
DELIMITER //

CREATE PROCEDURE COUNT_MEDICATION(IN PATIENT_ID CHAR(6),INOUT MED_COUNT INT )
BEGIN
	SELECT COUNT(PATIENT_ID)-1
    INTO MED_COUNT FROM MEDICATION_ORDER
    WHERE patient_id = PATIENT_ID;
END//

DELIMITER ;
SET @Quantity = 0; 
CALL COUNT_MEDICATION("PAT001",@Quantity);
SELECT @Quantity AS "QUANTITY";



DROP FUNCTION IF EXISTS CAL_EXP_DATE;
DELIMITER //

CREATE FUNCTION CAL_EXP_DATE()
RETURNS CHAR(40) DETERMINISTIC
BEGIN
	DECLARE DATES_LEFT INT;
    DECLARE MEDNAME VARCHAR(30);
    SELECT DATEDIFF(expire_date,CURRENT_DATE) INTO DATES_LEFT
    FROM MEDICATION
    WHERE DATEDIFF(expire_date,CURRENT_DATE) < 30;
    SELECT m_name INTO MEDNAME
    FROM MEDICATION
    WHERE DATEDIFF(expire_date,CURRENT_DATE) < 30;
    RETURN CONCAT(DATES_LEFT," ",MEDNAME);
END//
DELIMITER ;

SELECT CAL_EXP_DATE() AS "NEAR TO EXPIRE";


load xml
infile "D:/soft Eng ousl/Courses/2nd yr/2nd sem/EEI4366 EEX4366 Data Modelling and Database Systems/MP/patient.xml"
into table hospital_db.PATIENT
rows identified by '<patient>';

SELECT * FROM PATIENT;

load xml
infile "D:/soft Eng ousl/Courses/2nd yr/2nd sem/EEI4366 EEX4366 Data Modelling and Database Systems/MP/staff.xml"
into table hospital_db.STAFF
rows identified by '<staff>';

SELECT * FROM STAFF;