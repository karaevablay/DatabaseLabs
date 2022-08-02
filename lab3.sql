
-- Yerhanov Abylay Lab3

--LAB WORK 3
--Yerzhanov Abylay


--1.Write the following queries in SQL, using the university schema:
--a) Find all courses worth more than 3 credits
SELECT * FROM course WHERE credits>3

--b)Find all classrooms situated either in ‘Watson’ or ‘Packard’ buildings;
SELECT room_number FROM classroom
WHERE building = 'Watson' or building = 'Packard'

--c)Find all courses offered by the Computer Science department;
SELECT * FROM course
WHERE dept_name = 'Comp. Sci.'

--d)Find all courses offered during fall;
SELECT course_id FROM section WHERE semester = 'Fall'

--e)Find all students who have more than 45 credits but less than 90
SELECT * FROM student WHERE tot_cred > 45 and tot_cred < 90

--f)Find all students whose names end with vowels;
SELECT name FROM student
WHERE RIGHT(name,1) = 'a' or RIGHT(name,1) = 'e' 
      or RIGHT(name,1) = 'i' or RIGHT(name,1) = 'o' 
      or RIGHT(name,1) = 'u' or RIGHT(name,1) = 'y'

--g)Find all courses which have course ‘CS-101’ as their prerequisite;
SELECT course_id FROM prereq
WHERE prerequisite_id ='CS-101'

-----------------------------------------------------------------------------------------------------------------------------------
--2.Write the following queries in SQL, using the university schema:
--a)For each department, find the average salary of instructors in that department 
----and list them in ascending order. Assume that every department has at least one instructor
SELECT dept_name, AVG(salary) AS AVG
FROM instructor GROUP BY dept_name

--b)Find the building where the biggest number of courses takes place
SELECT building, count( course_id ) cnt
FROM section
GROUP BY building
ORDER BY cnt DESC
LIMIT 1;

--с)Find the department with the lowest number of courses offered;
SELECT dept_name, count(course_id) cnt FROM course
GROUP BY dept_name
ORDER BY cnt ASC
LIMIT 1;

--d)Find the ID and name of each student who has taken more than 3 courses
---from the Computer Science department;

SELECT takes.id,student.name, count(takes.id) as cnt FROM takes
INNER JOIN student
      ON takes.id = student.id
INNER JOIN course
      ON takes.course_id=course.course_id
WHERE course.dept_name = 'Comp. Sci.' GROUP BY takes.id, student.name HAVING count(*) > 3

--e)Find all instructors who work either in Biology, Philosophy, or Music departments;
SELECT name from instructor 
WHERE dept_name = 'Biology' or dept_name = 'Philosophy' 
      or dept_name = 'Music'

--f)Find all instructors who taught in the 2018 year but not in the 2017 year;
Select instructor.id, name FROM instructor
INNER JOIN teaches ON instructor.id = teaches.id
WHERE year = 2018 and not year = 2017
group by instructor.id

----------------------------------------------------------------------------------------------------------------------------------
--3.Write the following queries in SQL, using the university schema:
--a)Find all students who have taken Comp. Sci. course and got an excellent
---grade (i.e., A, or A-) and sort them alphabetically;
SELECT student.name
FROM takes
INNER JOIN course
ON takes.course_id = course.course_id
INNER JOIN student
ON takes.id = student.id
WHERE course.dept_name = 'Comp. Sci.' and (grade = 'A' or grade = 'A-')
GROUP BY student.name
ORDER BY student.name

--b)Find all advisors of students who got grades lower than B on any class;
SELECT name
FROM instructor
INNER JOIN advisor
ON instructor.id = advisor.i_id
INNER JOIN takes
ON advisor.s_id = takes.id
WHERE not takes.grade = 'A' AND not takes.grade = 'A-' AND not takes.grade = 'B' AND not takes.grade = 'B+'
GROUP BY name


--c)Find all departments whose students have never gotten an F or C grade;
SELECT student.dept_name FROM student
GROUP BY student.dept_name EXCEPT
SELECT student.dept_name FROM student
INNER JOIN takes on student.id = takes.id
WHERE grade = 'F' or grade = 'C' GROUP BY student.dept_name

--d)Find all instructors who have never given an A grade in any of the courses they taugh
SELECT teaches.id FROM teaches
GROUP BY teaches.id EXCEPT
SELECT teaches.id FROM teaches
INNER JOIN takes  on teaches.course_id = takes.course_id
WHERE grade = 'A' GROUP BY teaches.id

--e)Find all courses offered in the morning hours (i.e., courses ending before 13:00
SELECT course_id,end_hr,end_min FROM section
INNER JOIN time_slot on section.time_slot_id = time_slot.time_slot_id
WHERE end_hr < 13 group by course_id,end_hr,end_min ORDER BY end_hr
--------------------------------------------------------------------------------------------------------------------------