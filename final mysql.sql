DROP DATABASE IF EXISTS CLINIC_SYSTEM_MANAGEMENT5;
CREATE DATABASE CLINIC_SYSTEM_MANAGEMENT5;
USE CLINIC_SYSTEM_MANAGEMENT5;

CREATE TABLE DEPARTMENT (
    DepartmentID INT NOT NULL,
    Name VARCHAR(40) NOT NULL,
    PRIMARY KEY (DepartmentID)
);

CREATE TABLE CLINIC (
    ClinicID INT NOT NULL,
    Name VARCHAR(40) NOT NULL,
    Address VARCHAR(40) NOT NULL,
    DepartmentID INT,
    PRIMARY KEY (ClinicID),
    FOREIGN KEY (DepartmentID) REFERENCES DEPARTMENT(DepartmentID)
);

CREATE TABLE DOCTOR (
    DoctorID INT NOT NULL,
    Name VARCHAR(40) NOT NULL,
    Address VARCHAR(40) NOT NULL,
    DepartmentID INT,
    PRIMARY KEY (DoctorID),
    FOREIGN KEY (DepartmentID) REFERENCES DEPARTMENT(DepartmentID)
);

CREATE TABLE DOCTOR_PHONE (
    PhoneID INT AUTO_INCREMENT PRIMARY KEY,
    DoctorID INT,
    Phone_number VARCHAR(15),
    FOREIGN KEY (DoctorID) REFERENCES DOCTOR(DoctorID)
);

CREATE TABLE PATIENT (
    PatientID INT NOT NULL,
    Name VARCHAR(40) NOT NULL,
    Address VARCHAR(40) NOT NULL,
    Birth_date DATE,
    Job VARCHAR(40) NOT NULL,
    PRIMARY KEY (PatientID)
);

CREATE TABLE PATIENT_PHONE (
    PhoneID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    Phone_number VARCHAR(15),
    FOREIGN KEY (PatientID) REFERENCES PATIENT(PatientID)
);

CREATE TABLE TREAT (
    DoctorID INT NOT NULL,
    PatientID INT NOT NULL,
    PRIMARY KEY (DoctorID, PatientID),
    FOREIGN KEY (DoctorID) REFERENCES DOCTOR(DoctorID),
    FOREIGN KEY (PatientID) REFERENCES PATIENT(PatientID)
);

CREATE TABLE APPOINTMENT (
    AppointmentID INT NOT NULL,
    Date DATE,
    Cost INT,
    Start_time TIME,
    End_time TIME,
    Status VARCHAR(40) NOT NULL,
    Patient_diagnosis VARCHAR(40) NOT NULL,
    PatientID INT,
    DoctorID INT,
    PRIMARY KEY (AppointmentID),
    FOREIGN KEY (PatientID) REFERENCES PATIENT(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES DOCTOR(DoctorID)
);

-- Trigger: Prevent doctor from having overlapping appointment at the same time
DELIMITER //
CREATE TRIGGER prevent_double_booking
BEFORE INSERT ON APPOINTMENT
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1 FROM APPOINTMENT
        WHERE DoctorID = NEW.DoctorID
        AND Date = NEW.Date
        AND Start_time = NEW.Start_time
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Doctor already has an appointment at this time';
    END IF;
END;
//
DELIMITER ;





INSERT INTO DEPARTMENT (DepartmentID, Name) VALUES
(1, 'Ophtalmology'),
(2, 'Orthopedics'),
(3, 'Cardiology'),
(4, 'General Surgery'),
(5, 'Neurology'),
(6, 'Dermatology'),
(7, 'Psychiatry'),
(8, 'Otolaryngology(ENT)'),
(9, 'Pediatrics'),
(10, 'Urology');
 
INSERT INTO CLINIC (ClinicID, Name, Address, DepartmentID) VALUES
(101, 'Eye Care Clinic', 'Zone A', 1),
(102, 'Bone Clinic', 'Zone B', 2),
(103, 'Heart Clinic', 'Zone C', 3),
(104, 'Surgery Clinic', 'Zone D', 4),
(105, 'Brain & Nerves Clinic', 'Zone E', 5),
(106, 'Skin Clinic', 'Zone F', 6),
(107, 'Mental Health Clinic', 'Zone G', 7),
(108, 'Ear,Nose & Throat  Clinic', 'Zone H', 8),
(109, 'Kids Clinic', 'Zone I', 9),
(110, 'Urology Clinic', 'Zone G', 10);
 
INSERT INTO DOCTOR (DoctorID, Name, Address, DepartmentID) VALUES
(501, 'Dr. Ahmed Abd El Aziz', 'Helwan', 1),
(502, 'Dr. salma El Hefnawy', 'Maadi', 2),
(503, 'Dr. Eman Saad', '6th Of October', 3),
(504, 'Dr. Layla El Nagar', 'Giza', 4),
(505, 'Dr. Khaled El Hosary', 'Haram', 5),
(506, 'Dr. Youssef El Wazzan', 'El Sherouk', 6),
(507, 'Dr. Hana Abaas', 'Ain Shams', 7),
(508, 'Dr. Alaa Sameh', 'New Cairo', 8),
(509, 'Dr. Raya Atef', 'El Marg', 9),
(510, 'Dr. Rahaf Ali', 'El Salam', 10);
 
INSERT INTO DOCTOR_PHONE (PhoneID, DoctorID, Phone_number) VALUES
(1, 501, '0111524376'),
(2, 502, '0159273024'),
(3, 503, '0123745297'),
(4, 504, '0103826384'),
(5, 505, '0128373502'),
(6, 506, '0128682363'),
(7, 507, '0117383645'),
(8, 508, '0158937927'),
(9, 509, '0108393629'),
(10, 510, '0113474739');
 
INSERT INTO PATIENT (PatientID, Name, Address, Birth_date, Job) VALUES
(14632, 'Ayaat Ahmed', 'Sheikh Zayed', '1993-05-16', 'Software Engineer'),
(14633, 'Omar Khaled', 'Hadayek El Ahram', '1976-08-19', 'Archetict'),
(14634, 'Youssef Adel', '6th Of October', '2005-03-23', 'Student'),
(14635, 'Kareem Moustafa', 'Warraq', '1992-03-26', 'Doctor'),
(14636, 'noureen Fathy', 'Mokattam', '1985-02-22', 'Lawyer'),
(14637, 'Salma Ibrahim', 'Faisal', '1974-01-23', 'Journalist'),
(14638, 'Ahmed Samir', 'Giza Square', '1963-11-18', 'Marketing Specialist'),
(14639, 'Layla Tarek', 'Maadi', '1987-09-08', 'Nurse'),
(14640, 'Hany Magdy', 'Zamalek', '2003-05-15', 'Student'),
(14641, 'Sara Mohamed', 'Madinet Nasr', '1998-09-18', 'Photographer');
 
INSERT INTO PATIENT_PHONE (PhoneID, PatientID, Phone_number) VALUES
(1, 14632, '0124682637'),
(2, 14633, '0118379375'),
(3, 14634, '0106284692'),
(4, 14635, '0123629307'),
(5, 14636, '0115382978'),
(6, 14637, '0108376389'),
(7, 14638, '0119739297'),
(8, 14639, '0129836249'),
(9, 14640, '0103738365'),
(10, 14641, '0119364530');
 
INSERT INTO TREAT (DoctorID, PatientID) VALUES
(502, 14632),
(508, 14633),
(504, 14634),
(506, 14635),
(507, 14636),
(510, 14637),
(503, 14638),
(505, 14639),
(501, 14640),
(503, 14641);
 
INSERT INTO APPOINTMENT (AppointmentID, Date, Cost, Start_time, End_time, Status, Patient_diagnosis, PatientID, DoctorID) VALUES
(401, '2019-06-15', 150, '12:04:00', '12:25:00', 'Completed', 'Broken Leg', 14632, 502),
(402, '2018-03-12', 100, '08:15:00', '08:45:00', 'Completed', 'Ear infection', 14633, 508),
(403, '2023-10-20', 300, '10:30:00', '10:55:00', 'Completed', 'Appendix pain', 14634, 504),
(404, '2023-02-01', 200, '11:07:00', '11:40:00', 'Completed', 'Acne', 14635, 506),
(405, '2024-12-15', 500, '12:19:00', '12:45:00', 'Postponed', 'Anxiety', 14636, 507),
(406, '2024-09-10', 450, '13:17:00', '13:45:00', 'Completed', 'Kidney stones', 14637, 510),
(407, '2025-01-21', 260, '14:54:00', '15:15:00', 'In Progress', 'Diabetes', 14638, 503 ),
(408, '2025-05-19', 400, '15:19:00', '15:40:00', 'Scheduled', 'Headace', 14639, 505),
(409, '2021-04-22', 340, '18:43:00', '18:56:00', 'Scheduled', 'Blurry Vision', 14640, 501),
(410, '2024-06-30', 800, '20:16:00', '20:35:00', 'Completed', 'Chest Pain', 14641, 503);


UPDATE PATIENT
SET Address = 'New Cairo'
WHERE PatientID = 12527;


UPDATE DOCTOR_PHONE
SET Phone_number = '01112345678'
WHERE DoctorID = 2001;


UPDATE APPOINTMENT
SET Status = 'completed'
WHERE AppointmentID = 4001;


UPDATE APPOINTMENT
SET Patient_diagnosis = 'hypertension', Cost = 550
WHERE AppointmentID = 4003;


UPDATE CLINIC
SET Name = 'Advanced Heart Center'
WHERE ClinicID = 3001;


UPDATE PATIENT
SET Job = 'Software Developer'
WHERE PatientID = 12533;


UPDATE PATIENT
SET Birth_date = '1991-01-01'
WHERE PatientID = 12529;


UPDATE CLINIC
SET Address = 'New Downtown'
WHERE ClinicID = 3005;



SELECT * FROM PATIENT;


SELECT D.DoctorID, D.Name AS Doctor_Name, D.Address, Dept.Name AS Department_Name
FROM DOCTOR D
JOIN DEPARTMENT Dept ON D.DepartmentID = Dept.DepartmentID;


SELECT C.ClinicID, C.Name AS Clinic_Name, C.Address, Dept.Name AS Department_Name
FROM CLINIC C
JOIN DEPARTMENT Dept ON C.DepartmentID = Dept.DepartmentID;


SELECT A.AppointmentID, P.Name AS Patient_Name,
       Doc.Name AS Doctor_Name, A.Date, A.Start_time, A.End_time,
       A.Status, A.Patient_diagnosis, A.Cost
FROM APPOINTMENT A
JOIN PATIENT P ON A.PatientID = P.PatientID
JOIN DOCTOR Doc ON A.DoctorID = Doc.DoctorID
JOIN CLINIC C ON Doc.DepartmentID = C.DepartmentID;

CREATE VIEW vw_AppointmentDetails AS
SELECT A.AppointmentID, P.Name AS Patient_Name,
       Doc.Name AS Doctor_Name, A.Date, A.Start_time, A.End_time,
       A.Status, A.Patient_diagnosis, A.Cost
FROM APPOINTMENT A
JOIN PATIENT P ON A.PatientID = P.PatientID
JOIN DOCTOR Doc ON A.DoctorID = Doc.DoctorID
JOIN CLINIC C ON Doc.DepartmentID = C.DepartmentID;

CREATE VIEW vw_DoctorDetails AS
SELECT D.DoctorID, D.Name AS Doctor_Name, D.Address,
       Dept.Name AS Department_Name
FROM DOCTOR D
JOIN DEPARTMENT Dept ON D.DepartmentID = Dept.DepartmentID;


CREATE VIEW vw_PatientDetails AS
SELECT PatientID, Name AS Patient_Name, Birth_date, Address, Job
FROM PATIENT;
