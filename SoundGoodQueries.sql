SELECT EXTRACT(MONTH FROM timeslot) AS month, COUNT(*) AS total_lessons
FROM schedule
WHERE EXTRACT(YEAR FROM timeslot)='2022'
GROUP BY EXTRACT(MONTH FROM timeslot);


SELECT EXTRACT(MONTH FROM timeslot) AS month, priceclass.type_of_lesson, COUNT(*) AS total
FROM schedule
INNER JOIN priceclass ON schedule.price_id = priceclass.price_id
WHERE EXTRACT(YEAR FROM timeslot)='2022'
GROUP BY EXTRACT(MONTH FROM timeslot), priceclass.type_of_lesson;




SELECT COUNT(*)/12 AS average_lessons
FROM schedule
WHERE EXTRACT(YEAR FROM timeslot)='2022';

SELECT priceclass.type_of_lesson, COUNT(*)/12 AS average_unique
FROM schedule
INNER JOIN priceclass ON schedule.price_id = priceclass.price_id
WHERE EXTRACT(YEAR FROM timeslot)='2022'
GROUP BY priceclass.type_of_lesson;




SELECT instructor_id, COUNT(*) AS lessons_worked
FROM schedule
WHERE EXTRACT(MONTH FROM timeslot)=EXTRACT(MONTH FROM current_date)
GROUP BY instructor_id
HAVING COUNT(*) > 3
ORDER BY COUNT(*) DESC;





SELECT schedule.schedule_id, ensamblelesson.genre, timeslot,
CASE
WHEN (max_students-booked) < 1 THEN 'Lesson full'
WHEN (max_students-booked) = 1 THEN '1 spot left'
WHEN (max_students-booked) = 2 THEN '2 spot left'
ELSE 'Spots left'
END spots_left

FROM schedule
INNER JOIN ensamblelesson ON schedule.schedule_id=ensamblelesson.schedule_id
INNER JOIN booked_lessons ON schedule.schedule_id=booked_lessons.schedule_id
WHERE EXTRACT(WEEK FROM timeslot)=EXTRACT(WEEK FROM current_date+7)
ORDER BY ensamblelesson.genre, timeslot;

-- Task 4

SELECT * FROM instrument;
SELECT * FROM rentalinstruments;
SELECT * FROM rentableinstruments;

SELECT rentableinstruments.rentable_id, instrument.type, instrument.brand, instrument.instrument_price
FROM rentableinstruments
INNER JOIN instrument ON rentableinstruments.rental_instrument_id=instrument.rental_instrument_id 
WHERE rentableinstruments.rentable_id
NOT IN (
SELECT rentable_id FROM rentalinstruments 
WHERE current_date >= from_date and current_date < to_date)
AND instrument.type='Piano';

--checking student rental
SELECT COUNT(*) FROM rentalinstruments WHERE student_id='3' AND current_date < to_date;

--checking if instrument is available
SELECT COUNT(*) 
FROM rentableinstruments 
WHERE rentableinstruments.rentable_id='1' AND  rentableinstruments.rentable_id NOT IN (
SELECT rental_id 
FROM rentalinstruments
WHERE current_date >= from_date AND current_date < to_date); 

--insert a new rental
INSERT INTO rentalinstruments
VALUES ('14', '4', '0',current_date, current_date+365);

--terminate a rental
UPDATE rentalinstruments 
SET to_date = current_date 
WHERE rental_id = (
SELECT rental_id 
FROM rentalinstruments
WHERE rentable_id='8' AND student_id='3'
AND current_date < to_date
ORDER BY to_date DESC LIMIT 1);