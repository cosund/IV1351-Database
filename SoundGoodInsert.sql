INSERT INTO person VALUES 
('991123-0000','Katarina','Lindmark','991123','Street 3','12345','Townville','kl@mail.com','073-0393259'),
('971027-0669','Theodor','Staffas','971027','Street 69','67676','Townville','ts@mail.com','073-5784345'),
('990509-1234','Cornelia','Sundqvist','990509','Street 48','12345','Townville','cs@mail.com','073-5757334'),
('020202-4566','Molly','Jansson','020202','Street 43','79023','Townville','mj@mail.com','073-6748444'),
('800901-0044','Bert-Erik','Marklund','800901','Street 56B','75333','Townville','bem@mail.com','070-6663259'),
('690311-6677','Ing-Marie','Helkenen','690311','Street 55A','75333','Townville','imh@mail.com','076-4484345'),
('010103-0707','Yohanna','Sundin','010103','Street 5','12345','Townville','ys@mail.com','070-5904433'),
('020202-4566','Hannah','Jansson','871230','Street 48','79023','Townville','hj@mail.com','075-5738445');


INSERT INTO student 
VALUES 
VALUES ('0', (SELECT personal_nr FROM person WHERE first_name='Katarina' AND date_of_birth='991123'),'0702637485', 'gdug@live.se')
('1', (SELECT personal_nr FROM person WHERE first_name='Theodor' AND date_of_birth='971027'), '0707403847', 'hedö@live.se'),
('2', (SELECT personal_nr FROM person WHERE first_name='Cornelia' AND date_of_birth='990509'), '0707493748', 'odjf@live.se'),
('3', (SELECT personal_nr FROM person WHERE first_name='Molly' AND date_of_birth='020202'), '0773036479', 'yehf@live.se');

INSERT INTO instructor
VALUES
('I0', (SELECT personal_nr FROM person WHERE first_name='Bert-Erik' AND date_of_birth='800901')),
('I1', (SELECT personal_nr FROM person WHERE first_name='Ing-Marie' AND date_of_birth='690311'));

INSERT INTO schedule
VALUES
('S1', (SELECT instructor_id FROM instructor WHERE first_name='Bert-Erik'), ''),
('S2', (SELECT instructor_id FROM instructor WHERE first_name='Ing-Marie')),
;