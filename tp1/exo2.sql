-- Q1
DESCRIBE section;
SELECT * FROM section;

-- Q2
SELECT * FROM course;

-- Q3
SELECT title, dept_name FROM course;

-- Q4
SELECT dept_name, budget FROM department;

-- Q5
SELECT name, dept_name FROM instructor;

-- Q6
SELECT name FROM instructor
WHERE salary > 65000;

-- Q7
SELECT name FROM instructor
WHERE salary BETWEEN 55000 AND 85000;

-- Q8
SELECT DISTINCT dept_name FROM instructor;

-- Q9
SELECT name FROM instructor
WHERE dept_name = 'Comp. Sci.' AND salary > 65000;

-- Q10
SELECT * FROM section
WHERE semester = 'Spring' AND year = 2010;

-- Q11
SELECT title FROM course
WHERE dept_name = 'Comp. Sci.' AND credits > 3;

-- Q12
SELECT i.name, i.dept_name, d.building
FROM instructor i, department d
WHERE i.dept_name = d.dept_name;

-- Q13
SELECT DISTINCT s.name
FROM student s, takes t, course c
WHERE s.ID = t.ID
  AND t.course_id = c.course_id
  AND c.dept_name = 'Comp. Sci.';

-- Q14
SELECT DISTINCT s.name
FROM student s, takes t, teaches te, instructor i
WHERE s.ID = t.ID
  AND t.course_id = te.course_id
  AND t.sec_id    = te.sec_id
  AND t.semester  = te.semester
  AND t.year      = te.year
  AND te.ID = i.ID
  AND i.name = 'Einstein';

-- Q15
SELECT te.course_id, i.name
FROM teaches te, instructor i
WHERE te.ID = i.ID;

-- Q16
SELECT t.course_id, t.sec_id, COUNT(*) AS nb_inscrits
FROM takes t
WHERE t.semester = 'Spring' AND t.year = 2010
GROUP BY t.course_id, t.sec_id;

-- Q17
SELECT dept_name, MAX(salary) AS salaire_max
FROM instructor
GROUP BY dept_name;

--Q 18
SELECT course_id, sec_id, semester, year, COUNT(*) AS nb_inscrits
FROM takes
GROUP BY course_id, sec_id, semester, year;

--Q19
SELECT s.building, COUNT(*) AS nb_cours
FROM section s
WHERE (s.semester = 'Fall'   AND s.year = 2009)
   OR (s.semester = 'Spring' AND s.year = 2010)
GROUP BY s.building;

-- Q20
SELECT c.dept_name, COUNT(*) AS nb_cours
FROM course c, section s, department d
WHERE c.course_id  = s.course_id
  AND c.dept_name  = d.dept_name
  AND s.building   = d.building
GROUP BY c.dept_name;

-- Q21
SELECT DISTINCT c.title, i.name
FROM course c, teaches te, instructor i, section s
WHERE c.course_id  = te.course_id
  AND te.ID        = i.ID
  AND te.course_id = s.course_id
  AND te.sec_id    = s.sec_id
  AND te.semester  = s.semester
  AND te.year      = s.year;

-- Q22
SELECT semester, COUNT(*) AS nb_cours
FROM section
WHERE semester IN ('Summer', 'Fall', 'Spring')
GROUP BY semester;

-- Q23
SELECT t.ID, s.name, SUM(c.credits) AS credits_hors_dept
FROM takes t, student s, course c
WHERE t.ID = s.ID
  AND t.course_id = c.course_id
  AND c.dept_name <> s.dept_name
GROUP BY t.ID, s.name;

-- Q24
SELECT c.dept_name, SUM(c.credits) AS total_credits
FROM course c, section s, department d
WHERE c.course_id = s.course_id
  AND c.dept_name = d.dept_name
  AND s.building  = d.building
GROUP BY c.dept_name;
