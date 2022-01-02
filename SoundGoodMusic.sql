CREATE TABLE instructorPayments (
 from_date TIMESTAMP(0),
 to_date TIMESTAMP(0)
);


CREATE TABLE paymentClass (
 payment_id VARCHAR(10) NOT NULL,
 payment_price INT,
 lesson_type VARCHAR(10),
 lesson_level VARCHAR(10)
);

ALTER TABLE paymentClass ADD CONSTRAINT PK_paymentClass PRIMARY KEY (payment_id);


CREATE TABLE person (
 personal_nr VARCHAR(12) NOT NULL,
 first_name VARCHAR(255) NOT NULL,
 last_name VARCHAR(255),
 date_of_birth VARCHAR(8),
 street VARCHAR(255),
 zip VARCHAR(5),
 city VARCHAR(255),
 email VARCHAR(255),
 phone_number VARCHAR(15)
);

ALTER TABLE person ADD CONSTRAINT PK_person PRIMARY KEY (personal_nr);


CREATE TABLE priceClass (
 price_id VARCHAR(10) NOT NULL,
 price INT,
 type_of_lesson VARCHAR(255),
 level_of_lesson VARCHAR(255)
);

ALTER TABLE priceClass ADD CONSTRAINT PK_priceClass PRIMARY KEY (price_id);


CREATE TABLE student (
 student_id VARCHAR(10) NOT NULL,
 personal_nr VARCHAR(12) NOT NULL,
 parent_number VARCHAR(15),
 parent_email VARCHAR(10)
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (student_id);


CREATE TABLE enrollApplication (
 application_id VARCHAR(10) NOT NULL,
 student_id VARCHAR(10) NOT NULL,
 instrument VARCHAR(10),
 skill VARCHAR(10),
 application_date TIMESTAMP(0)
);

ALTER TABLE enrollApplication ADD CONSTRAINT PK_enrollApplication PRIMARY KEY (application_id,student_id);


CREATE TABLE instructor (
 instructor_id VARCHAR(10) NOT NULL,
 personal_nr VARCHAR(12) NOT NULL
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (instructor_id);


CREATE TABLE instrument (
 instrument_id VARCHAR(10) NOT NULL,
 type VARCHAR(255),
 skill_level VARCHAR(10),
 instructor_id VARCHAR(10) NOT NULL,
 student_id VARCHAR(10)
);

ALTER TABLE instrument ADD CONSTRAINT PK_instrument PRIMARY KEY (instrument_id);


CREATE TABLE rentalInstruments (
 rental_id VARCHAR(10) NOT NULL,
 from_date TIMESTAMP(0),
 to_date TIMESTAMP(0),
 student_id VARCHAR(10),
 type_of_instrument VARCHAR(255)
);

ALTER TABLE rentalInstruments ADD CONSTRAINT PK_rentalInstruments PRIMARY KEY (rental_id);


CREATE TABLE schedule (
 schedule_id VARCHAR(10) NOT NULL,
 instructor_id VARCHAR(10) NOT NULL,
 timeslot TIMESTAMP(10) NOT NULL
);

ALTER TABLE schedule ADD CONSTRAINT PK_schedule PRIMARY KEY (schedule_id,instructor_id);


CREATE TABLE ensambleLesson (
 schedule_id VARCHAR(10),
 level VARCHAR(10),
 genre VARCHAR(10),
 min_students VARCHAR(10),
 max_students VARCHAR(10),
 instructor_id VARCHAR(10),
 price_id VARCHAR(10) NOT NULL,
 payment_id VARCHAR(10) NOT NULL
);


CREATE TABLE groupLesson (
 schedule_id VARCHAR(10),
 level VARCHAR(10),
 min_students VARCHAR(10),
 instructor_id VARCHAR(10),
 price_id VARCHAR(10) NOT NULL,
 payment_id VARCHAR(10) NOT NULL
);


CREATE TABLE individualLesson (
 schedule_id VARCHAR(10),
 level VARCHAR(128),
 instructor_id VARCHAR(10),
 price_id VARCHAR(10) NOT NULL,
 payment_id VARCHAR(10) NOT NULL
);


CREATE TABLE studentFees (
 student_id VARCHAR(10) NOT NULL,
 rental_id VARCHAR(10) NOT NULL,
 from_date TIMESTAMP(0),
 to_date TIMESTAMP(0),
 sibling_discount BIT(2)
);

ALTER TABLE studentFees ADD CONSTRAINT PK_studentFees PRIMARY KEY (student_id);


ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (personal_nr) REFERENCES person (personal_nr);


ALTER TABLE enrollApplication ADD CONSTRAINT FK_enrollApplication_0 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE instructor ADD CONSTRAINT FK_instructor_0 FOREIGN KEY (personal_nr) REFERENCES person (personal_nr);


ALTER TABLE instrument ADD CONSTRAINT FK_instrument_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);
ALTER TABLE instrument ADD CONSTRAINT FK_instrument_1 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE rentalInstruments ADD CONSTRAINT FK_rentalInstruments_0 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE schedule ADD CONSTRAINT FK_schedule_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);


ALTER TABLE ensambleLesson ADD CONSTRAINT FK_ensambleLesson_0 FOREIGN KEY (schedule_id,instructor_id) REFERENCES schedule (schedule_id,instructor_id);
ALTER TABLE ensambleLesson ADD CONSTRAINT FK_ensambleLesson_1 FOREIGN KEY (price_id) REFERENCES priceClass (price_id);
ALTER TABLE ensambleLesson ADD CONSTRAINT FK_ensambleLesson_2 FOREIGN KEY (payment_id) REFERENCES paymentClass (payment_id);


ALTER TABLE groupLesson ADD CONSTRAINT FK_groupLesson_0 FOREIGN KEY (schedule_id,instructor_id) REFERENCES schedule (schedule_id,instructor_id);
ALTER TABLE groupLesson ADD CONSTRAINT FK_groupLesson_1 FOREIGN KEY (price_id) REFERENCES priceClass (price_id);
ALTER TABLE groupLesson ADD CONSTRAINT FK_groupLesson_2 FOREIGN KEY (payment_id) REFERENCES paymentClass (payment_id);


ALTER TABLE individualLesson ADD CONSTRAINT FK_individualLesson_0 FOREIGN KEY (schedule_id,instructor_id) REFERENCES schedule (schedule_id,instructor_id);
ALTER TABLE individualLesson ADD CONSTRAINT FK_individualLesson_1 FOREIGN KEY (price_id) REFERENCES priceClass (price_id);
ALTER TABLE individualLesson ADD CONSTRAINT FK_individualLesson_2 FOREIGN KEY (payment_id) REFERENCES paymentClass (payment_id);


ALTER TABLE studentFees ADD CONSTRAINT FK_studentFees_0 FOREIGN KEY (student_id) REFERENCES student (student_id);
ALTER TABLE studentFees ADD CONSTRAINT FK_studentFees_1 FOREIGN KEY (rental_id) REFERENCES rentalInstruments (rental_id);


