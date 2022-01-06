INSERT INTO person VALUES 
('991123-0000','Katarina','Lindmark','991123','Street 3','12345','Townville','kl@mail.com','073-0393259'),
('971027-0669','Theodor','Staffas','971027','Street 69','67676','Townville','ts@mail.com','073-5784345'),
('990509-1234','Cornelia','Sundqvist','990509','Street 48','12345','Townville','cs@mail.com','073-5757334'),
('020202-4566','Molly','Sundin','020202','Street 43','79023','Townville','mj@mail.com','073-6748444'),
('800901-0044','Bert-Erik','Marklund','800901','Street 56B','75333','Townville','bem@mail.com','070-6663259'),
('690311-6677','Ing-Marie','Helkenen','690311','Street 55A','75333','Townville','imh@mail.com','076-4484345'),
('010103-0707','Yohanna','Sundin','010103','Street 5','12345','Townville','ys@mail.com','070-5904433'),
('871230-4556','Hannah','Jansson','871230','Street 48','79023','Townville','hj@mail.com','075-5738445'),
('690530-0911','Kurt','Olsson','561130','Street 16A','75333','Townville','ko@mail.com','076-5765445'),
('031020-1121','Sanna','Morrison','031020','Street 16B','75333','Townville','sm@mail.com','075-6711234'),
('830318-0431','Ylva','Axelsson','830318','Street 14B','75333','Townville','ya@mail.com','070-5331965'),
('020522-0341','Isabella','Johansson','020522','Street 13B','75333','Townville','ij@mail.com','073-57657745');

INSERT INTO student VALUES 
('0', (SELECT personal_nr FROM person WHERE first_name='Katarina' AND date_of_birth='991123'),'0702637485', 'gdug@live.se'),
('1', (SELECT personal_nr FROM person WHERE first_name='Theodor' AND date_of_birth='971027'), '0707403847', 'hedu@live.se'),
('2', (SELECT personal_nr FROM person WHERE first_name='Cornelia' AND date_of_birth='990509'), '0707493748', 'odjf@live.se'),
('3', (SELECT personal_nr FROM person WHERE first_name='Molly' AND date_of_birth='020202'), '0773036479', 'yehf@live.se'),
('4', (SELECT personal_nr FROM person WHERE first_name='Yohanna' AND date_of_birth='010103'), '0775043098', 'gdfd@live.se'),
('5', (SELECT personal_nr FROM person WHERE first_name='Sanna' AND date_of_birth='031020'), '0776539281', 'nfcj@live.se'),
('6', (SELECT personal_nr FROM person WHERE first_name='Isabella' AND date_of_birth='020522'), '078574937', 'gnds@live.se');

INSERT INTO instructor VALUES
('I0', (SELECT personal_nr FROM person WHERE first_name='Bert-Erik' AND date_of_birth='800901')),
('I1', (SELECT personal_nr FROM person WHERE first_name='Ing-Marie' AND date_of_birth='690311')),
('I2', (SELECT personal_nr FROM person WHERE first_name='Kurt' AND date_of_birth='561130')),
('I3', (SELECT personal_nr FROM person WHERE first_name='Ylva' AND date_of_birth='830318'));

INSERT INTO enrollApplication
VALUES
('A1', (SELECT student_id FROM student WHERE personal_nr='991123-0000'), 'Piano', 'Beginner', '2021-12-01 08:15:45'),
('A2', (SELECT student_id FROM student WHERE personal_nr='971027-0669'), 'Guitar', 'Intermediate', '2021-12-01 08:15:45'),
('A3', (SELECT student_id FROM student WHERE personal_nr='990509-1234'), 'Base', 'Intermediate', '2021-12-01 08:15:45'),
('A4', (SELECT student_id FROM student WHERE personal_nr='020202-4566'), 'Piano', 'Beginner', '2021-12-01 08:15:45'),
('A5', (SELECT student_id FROM student WHERE personal_nr='031020-1121'), 'Saxophone', 'Advanced', '2021-12-01 08:15:45'),
('A6', (SELECT student_id FROM student WHERE personal_nr='020522-0341'), 'Violin', 'Advanced', '2021-12-01 08:15:45'),
('A7', (SELECT student_id FROM student WHERE personal_nr='020522-0341'), 'Piano', 'Beginner', '2021-12-01 08:15:45');

INSERT INTO priceClass
VALUES
('P1', '150', 'Indivudual', 'Beginner'),
('P2', '150', 'Indivudual', 'Intermediate'),
('P3', '300', 'Indivudual', 'Advanced'),
('P4', '100', 'Group', 'Beginner'),
('P5', '100', 'Group', 'Intermediate'),
('P6', '200', 'Group', 'Advanced'),
('P7', '200', 'Essembly', 'Beginner'),
('P8', '200', 'Essembly', 'Intermediate'),
('P9', '400', 'Essembly', 'Advanced'),
('P10', '150', 'Indivudual', 'Beginner'),
('P11', '150', 'Indivudual', 'Intermediate'),
('P12', '200', 'Essembly', 'Beginner'),
('P13', '200', 'Essembly', 'Intermediate'),
('P14', '400', 'Essembly', 'Advanced');

INSERT INTO schedule VALUES
-- January 2022
('S1', (SELECT instructor_id FROM instructor WHERE personal_nr='800901-0044'), (SELECT price_id FROM priceClass WHERE price_id='P1'), '2022-01-01 08:00:00', '2022-01-01 10:00:00'),
('S10', (SELECT instructor_id FROM instructor WHERE personal_nr='830318-0431'), (SELECT price_id FROM priceClass WHERE price_id='P10'), '2022-01-01 13:00:00', '2022-01-01 15:00:00'),
('S11', (SELECT instructor_id FROM instructor WHERE personal_nr='830318-0431'), (SELECT price_id FROM priceClass WHERE price_id='P11'), '2022-01-01 13:00:00', '2022-01-01 15:00:00'),
('S2', (SELECT instructor_id FROM instructor WHERE personal_nr='690530-0911'), (SELECT price_id FROM priceClass WHERE price_id='P2'), '2022-01-02 10:00:00', '2022-01-02 12:00:00'),
('S7', (SELECT instructor_id FROM instructor WHERE personal_nr='690311-6677'), (SELECT price_id FROM priceClass WHERE price_id='P7'), '2022-01-12 08:00:00', '2022-01-12 10:00:00'),
('S8', (SELECT instructor_id FROM instructor WHERE personal_nr='830318-0431'), (SELECT price_id FROM priceClass WHERE price_id='P8'), '2022-01-13 12:00:00', '2022-01-13 14:00:00'),
('S9', (SELECT instructor_id FROM instructor WHERE personal_nr='830318-0431'), (SELECT price_id FROM priceClass WHERE price_id='P9'), '2022-01-14 10:00:00', '2022-01-14 12:00:00'),
('S12', (SELECT instructor_id FROM instructor WHERE personal_nr='690311-6677'), (SELECT price_id FROM priceClass WHERE price_id='P12'), '2022-01-19 08:00:00', '2022-01-12 10:00:00'),
('S13', (SELECT instructor_id FROM instructor WHERE personal_nr='830318-0431'), (SELECT price_id FROM priceClass WHERE price_id='P13'), '2022-01-20 12:00:00', '2022-01-13 14:00:00'),
('S14', (SELECT instructor_id FROM instructor WHERE personal_nr='830318-0431'), (SELECT price_id FROM priceClass WHERE price_id='P14'), '2022-01-21 10:00:00', '2022-01-14 12:00:00'),
-- February 2022
('S3', (SELECT instructor_id FROM instructor WHERE personal_nr='690530-0911'), (SELECT price_id FROM priceClass WHERE price_id='P3'), '2022-02-01 08:00:00', '2022-02-01 10:00:00'),
('S4', (SELECT instructor_id FROM instructor WHERE personal_nr='800901-0044'), (SELECT price_id FROM priceClass WHERE price_id='P4'), '2022-02-01 10:00:00', '2022-02-01 12:00:00'),
('S5', (SELECT instructor_id FROM instructor WHERE personal_nr='690311-6677'), (SELECT price_id FROM priceClass WHERE price_id='P5'), '2022-02-01 13:00:00', '2022-02-01 15:00:00'),
('S6', (SELECT instructor_id FROM instructor WHERE personal_nr='690311-6677'), (SELECT price_id FROM priceClass WHERE price_id='P6'),'2022-02-03 08:00:00', '2022-02-03 10:00:00');


INSERT INTO paymentClass
VALUES
('PA1', '150', 'Indivudual', 'Beginner'),
('PA2', '150', 'Indivudual', 'Intermediate'),
('PA3', '300', 'Indivudual', 'Advanced'),
('PA4', '100', 'Group', 'Beginner'),
('PA5', '100', 'Group', 'Intermediate'),
('PA6', '200', 'Group', 'Advanced'),
('PA7', '200', 'Essembly', 'Beginner'),
('PA8', '200', 'Essembly', 'Intermediate'),
('PA9', '400', 'Essembly', 'Advanced'),
('PA10', '150', 'Indivudual', 'Beginner'),
('PA11', '150', 'Indivudual', 'Intermediate'),
('PA12', '200', 'Essembly', 'Beginner'),
('PA13', '200', 'Essembly', 'Intermediate'),
('PA14', '400', 'Essembly', 'Advanced');

INSERT INTO individualLesson
VALUES
('S1', 'Beginner', 'PA1'),
('S10', 'Beginner', 'PA10'),
('S2', 'Intermediate', 'PA2'),
('S3', 'Advanced', 'PA3'),
('S11', 'Intermediate', 'PA11');


INSERT INTO groupLesson
VALUES
('S4', 'Beginner', '7', 'PA4'),
('S5', 'Intermediate', '5', 'PA5'),
('S6', 'Advanced', '3', 'PA6');

INSERT INTO ensambleLesson
VALUES
('S7','Beginner','Classic','2', '5',     'PA7'),
('S8', 'Intermediate', 'Rock', '2', '5', 'PA8'),
('S9', 'Advanced', 'HipHop', '2', '5',   'PA9'),
('S12', 'Beginner', 'Rock', '2', '5', 'PA12'),
('S13', 'Intermediate', 'Metal', '2', '5', 'PA13'),
('S14', 'Advanced', 'Metalcore', '2', '5', 'PA14');

INSERT INTO instructorPayments
VALUES
('2021-12-01 00:00:00', '2022-01-01 00:00:00'),
('2021-11-01 00:00:00', '2021-12-01 00:00:00'),
('2021-10-01 00:00:00', '2021-11-01 00:00:00'),
('2021-09-01 00:00:00', '2021-10-01 00:00:00'),
('2021-08-01 00:00:00', '2021-09-01 00:00:00');

INSERT INTO instrument
VALUES
('IN1', 'Piano', 'Bechstein', '1000'),
('IN2', 'Piano', 'Bechstein', '1000'),
('IN3', 'Piano', 'FAZIOLI', '2000'),
('IN4', 'Guitar', 'Fender', '500'),
('IN5', 'Guitar', 'Jackson', '1200'),
('IN6', 'Bass', 'Gibson', '800'),
('IN7', 'Bass', 'Schecter', '700'),
('IN8', 'Violin', 'Mendini', '1300'),
('IN9', 'Violin', 'Mendini', '13'),
('IN10', 'Violin', 'Stradivarius', '10000'),
('IN11', 'Piano', 'Bechstein', '1000'),
('IN12', 'Piano', 'FAZIOLI', '2000'),
('IN13', 'Guitar', 'Fender', '500'),
('IN14', 'Guitar', 'Jackson', '1200'); 

INSERT INTO rentableInstruments
VALUES
('1', 'IN1'), 
('2', 'IN2'), 
('3', 'IN3'), 
('4', 'IN4'), 
('5', 'IN5'), 
('6', 'IN6'), 
('7', 'IN7'), 
('8', 'IN8'), 
('9', 'IN9'), 
('10', 'IN10'),
('11', 'IN11'),
('12', 'IN12'),
('13', 'IN13'),
('14', 'IN14');

INSERT INTO rentalInstruments
VALUES
('1', '1', '0', '2021-12-01 00:00:00', '2022-02-01 00:00:00'),
('2', '5', '0', '2021-11-06 00:00:00', '2022-01-01 00:00:00'),
('3', '4', '3', '2021-10-07 00:00:00', '2022-03-01 00:00:00'),
('4', '6', '4', '2021-12-01 00:00:00', '2022-01-01 00:00:00'),
('5', '7', '5', '2021-11-05 00:00:00', '2012-07-01 00:00:00'),
('6', '8', '3', '2021-11-01 00:00:00', '2022-02-01 00:00:00'),
('7', '9', '2', '2021-11-01 00:00:00', '2022-02-01 00:00:00');

INSERT INTO studentFees
VALUES
('1', '0', '2021-12-01 00:00:00', '2022-02-01 00:00:00', '0'),
('2', '0', '2021-11-06 00:00:00', '2022-01-01 00:00:00', '0'),
('3', '3', '2021-10-07 00:00:00', '2022-03-01 00:00:00', '0'),
('4', '4', '2021-12-01 00:00:00', '2022-01-01 00:00:00', '0'),
('5', '5', '2021-11-05 00:00:00', '2012-07-01 00:00:00', '0'),
('6', '3', '2021-11-01 00:00:00', '2022-02-01 00:00:00', '1'),
('7', '2', '2021-11-01 00:00:00', '2022-02-01 00:00:00', '1');

INSERT INTO participants
VALUES
((SELECT student_id FROM student WHERE personal_nr='991123-0000'), 'S1'),
((SELECT student_id FROM student WHERE personal_nr='971027-0669'), 'S2'),
((SELECT student_id FROM student WHERE personal_nr='971027-0669'), 'S3'),
((SELECT student_id FROM student WHERE personal_nr='971027-0669'), 'S4'),
((SELECT student_id FROM student WHERE personal_nr='991123-0000'), 'S4'),
((SELECT student_id FROM student WHERE personal_nr='971027-0669'), 'S5'),
((SELECT student_id FROM student WHERE personal_nr='991123-0000'), 'S5'),
((SELECT student_id FROM student WHERE personal_nr='971027-0669'), 'S6'),
((SELECT student_id FROM student WHERE personal_nr='991123-0000'), 'S6'),
((SELECT student_id FROM student WHERE personal_nr='971027-0669'), 'S7'),
((SELECT student_id FROM student WHERE personal_nr='991123-0000'), 'S7'),
((SELECT student_id FROM student WHERE personal_nr='971027-0669'), 'S8'),
((SELECT student_id FROM student WHERE personal_nr='020522-0341'), 'S8'),
((SELECT student_id FROM student WHERE personal_nr='991123-0000'), 'S8'),
((SELECT student_id FROM student WHERE personal_nr='971027-0669'), 'S9'),
((SELECT student_id FROM student WHERE personal_nr='010103-0707'), 'S9'),
((SELECT student_id FROM student WHERE personal_nr='020202-4566'), 'S9'),
((SELECT student_id FROM student WHERE personal_nr='031020-1121'), 'S9'),
((SELECT student_id FROM student WHERE personal_nr='991123-0000'), 'S9'),
((SELECT student_id FROM student WHERE personal_nr='971027-0669'), 'S12'),
((SELECT student_id FROM student WHERE personal_nr='991123-0000'), 'S12'),
((SELECT student_id FROM student WHERE personal_nr='971027-0669'), 'S13'),
((SELECT student_id FROM student WHERE personal_nr='991123-0000'), 'S13'),
((SELECT student_id FROM student WHERE personal_nr='020522-0341'), 'S13'),
((SELECT student_id FROM student WHERE personal_nr='971027-0669'), 'S14'),
((SELECT student_id FROM student WHERE personal_nr='010103-0707'), 'S14'),
((SELECT student_id FROM student WHERE personal_nr='020522-0341'), 'S14'),
((SELECT student_id FROM student WHERE personal_nr='031020-1121'), 'S14'),
((SELECT student_id FROM student WHERE personal_nr='991123-0000'), 'S14');


CREATE VIEW booked_lessons AS
SELECT schedule_id, COUNT(*) AS booked
FROM participants
GROUP BY schedule_id
ORDER BY schedule_id;
