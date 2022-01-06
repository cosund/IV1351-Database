CREATE TABLE instructorPayments (
 from_date TIMESTAMP(0),
 to_date TIMESTAMP(0)
);


CREATE TABLE instrument (
 rental_instrument_id VARCHAR(10) NOT NULL,
 type VARCHAR(255) NOT NULL,
 brand VARCHAR(255) NOT NULL,
 instrument_price INT NOT NULL
);

ALTER TABLE instrument ADD CONSTRAINT PK_instrument PRIMARY KEY (rental_instrument_id);


CREATE TABLE paymentClass (
 payment_id VARCHAR(10) NOT NULL,
 payment_price INT,
 lesson_type VARCHAR(255),
 lesson_level VARCHAR(255)
);

ALTER TABLE paymentClass ADD CONSTRAINT PK_paymentClass PRIMARY KEY (payment_id);


CREATE TABLE person (
 personal_nr VARCHAR(12) NOT NULL,
 first_name VARCHAR(255) NOT NULL,
 last_name VARCHAR(255) NOT NULL,
 date_of_birth VARCHAR(8) NOT NULL,
 street VARCHAR(255) NOT NULL,
 zip VARCHAR(5) NOT NULL,
 city VARCHAR(255) NOT NULL,
 email VARCHAR(255),
 phone_number VARCHAR(255)
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
 parent_number VARCHAR(255),
 parent_email VARCHAR(255)
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (student_id);


CREATE TABLE enrollApplication (
 application_id VARCHAR(10) NOT NULL,
 student_id VARCHAR(10) NOT NULL,
 instrument VARCHAR(255),
 skill VARCHAR(255),
 application_date TIMESTAMP(0)
);

ALTER TABLE enrollApplication ADD CONSTRAINT PK_enrollApplication PRIMARY KEY (application_id,student_id);


CREATE TABLE instructor (
 instructor_id VARCHAR(10) NOT NULL,
 personal_nr VARCHAR(12) NOT NULL
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (instructor_id);


CREATE TABLE rentalInstruments (
 rental_instrument_id VARCHAR(10) NOT NULL,
 student_id VARCHAR(10) NOT NULL,
 from_date TIMESTAMP(0),
 to_date TIMESTAMP(0)
);

ALTER TABLE rentalInstruments ADD CONSTRAINT PK_rentalInstruments PRIMARY KEY (rental_instrument_id);


CREATE TABLE schedule (
 schedule_id VARCHAR(10) NOT NULL,
 instructor_id VARCHAR(10) NOT NULL,
 price_id VARCHAR(10) NOT NULL,
 timeslot TIMESTAMP(0) NOT NULL,
 timeend TIMESTAMP(0)
);

ALTER TABLE schedule ADD CONSTRAINT PK_schedule PRIMARY KEY (schedule_id);


CREATE TABLE ensambleLesson (
 schedule_id VARCHAR(10),
 level VARCHAR(255),
 genre VARCHAR(255),
 min_students INT,
 max_students INT,
 payment_id VARCHAR(10) NOT NULL
);


CREATE TABLE groupLesson (
 schedule_id VARCHAR(10),
 level VARCHAR(255),
 min_students VARCHAR(255),
 payment_id VARCHAR(255) NOT NULL
);


CREATE TABLE individualLesson (
 schedule_id VARCHAR(10),
 level VARCHAR(255),
 payment_id VARCHAR(10) NOT NULL
);


CREATE TABLE participants (
 student_id VARCHAR(10) NOT NULL,
 schedule_id VARCHAR(10) NOT NULL
);

ALTER TABLE participants ADD CONSTRAINT PK_participants PRIMARY KEY (student_id,schedule_id);


CREATE TABLE studentFees (
 rental_instrument_id VARCHAR(10),
 student_id VARCHAR(10) NOT NULL,
 pay_from_date TIMESTAMP(0),
 pay_to_date TIMESTAMP(0),
 sibling_discount BIT(1)
);


ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (personal_nr) REFERENCES person (personal_nr);


ALTER TABLE enrollApplication ADD CONSTRAINT FK_enrollApplication_0 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE instructor ADD CONSTRAINT FK_instructor_0 FOREIGN KEY (personal_nr) REFERENCES person (personal_nr);


ALTER TABLE rentalInstruments ADD CONSTRAINT FK_rentalInstruments_0 FOREIGN KEY (rental_instrument_id) REFERENCES instrument (rental_instrument_id);
ALTER TABLE rentalInstruments ADD CONSTRAINT FK_rentalInstruments_1 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE schedule ADD CONSTRAINT FK_schedule_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);
ALTER TABLE schedule ADD CONSTRAINT FK_schedule_1 FOREIGN KEY (price_id) REFERENCES priceClass (price_id);


ALTER TABLE ensambleLesson ADD CONSTRAINT FK_ensambleLesson_0 FOREIGN KEY (schedule_id) REFERENCES schedule (schedule_id);
ALTER TABLE ensambleLesson ADD CONSTRAINT FK_ensambleLesson_1 FOREIGN KEY (payment_id) REFERENCES paymentClass (payment_id);


ALTER TABLE groupLesson ADD CONSTRAINT FK_groupLesson_0 FOREIGN KEY (schedule_id) REFERENCES schedule (schedule_id);
ALTER TABLE groupLesson ADD CONSTRAINT FK_groupLesson_1 FOREIGN KEY (payment_id) REFERENCES paymentClass (payment_id);


ALTER TABLE individualLesson ADD CONSTRAINT FK_individualLesson_0 FOREIGN KEY (schedule_id) REFERENCES schedule (schedule_id);
ALTER TABLE individualLesson ADD CONSTRAINT FK_individualLesson_1 FOREIGN KEY (payment_id) REFERENCES paymentClass (payment_id);


ALTER TABLE participants ADD CONSTRAINT FK_participants_0 FOREIGN KEY (student_id) REFERENCES student (student_id);
ALTER TABLE participants ADD CONSTRAINT FK_participants_1 FOREIGN KEY (schedule_id) REFERENCES schedule (schedule_id);


ALTER TABLE studentFees ADD CONSTRAINT FK_studentFees_0 FOREIGN KEY (student_id) REFERENCES student (student_id);
ALTER TABLE studentFees ADD CONSTRAINT FK_studentFees_1 FOREIGN KEY (rental_instrument_id) REFERENCES rentalInstruments (rental_instrument_id);


