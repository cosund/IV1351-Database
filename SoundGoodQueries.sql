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

SELECT * FROM booked_lessons;
SELECT * FROM participants;
SELECT * FROM ensamblelesson;
SELECT * FROM schedule;
SELECT * FROM priceclass;


SELECT * FROM instrument;
SELECT * FROM rentalinstruments;

SELECT type
FROM instrument
WHERE type=?;

-- ändra integer på min och max students på astah och sql kod