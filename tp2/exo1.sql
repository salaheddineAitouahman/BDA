-- Q1
SELECT dept_name FROM department
WHERE budget = (SELECT MAX(budget) FROM department);

-- Q2
SELECT name, salary FROM instructor
WHERE salary > (SELECT AVG(salary) FROM instructor);

-- Q3
SELECT te.ID AS prof_id, i.name AS prof_name,
       t.ID  AS etud_id, s.name AS etud_name,
       COUNT(*) AS nb_cours
FROM teaches te, takes t, instructor i, student s
WHERE te.course_id = t.course_id
  AND te.sec_id    = t.sec_id
  AND te.semester  = t.semester
  AND te.year      = t.year
  AND te.ID = i.ID
  AND t.ID  = s.ID
GROUP BY te.ID, i.name, t.ID, s.name
HAVING COUNT(*) > 2;

-- Q4
SELECT * FROM (
    SELECT te.ID AS prof_id, i.name AS prof_name,
           t.ID  AS etud_id, s.name AS etud_name,
           COUNT(*) AS nb_cours
    FROM teaches te, takes t, instructor i, student s
    WHERE te.course_id = t.course_id
      AND te.sec_id    = t.sec_id
      AND te.semester  = t.semester
      AND te.year      = t.year
      AND te.ID = i.ID
      AND t.ID  = s.ID
    GROUP BY te.ID, i.name, t.ID, s.name
)
WHERE nb_cours > 2;

-- Q5
SELECT DISTINCT s.ID, s.name
FROM student s
WHERE s.ID NOT IN (
    SELECT ID FROM takes WHERE year < 2010
);

-- Q6
SELECT name FROM instructor
WHERE name LIKE 'E%';

-- Q7
SELECT name, salary FROM instructor
WHERE salary = (
    SELECT MIN(salary) FROM (
        SELECT DISTINCT salary FROM instructor
        ORDER BY salary DESC
        FETCH FIRST 4 ROWS ONLY
    )
);

-- Q8
SELECT name, salary FROM (
    SELECT name, salary FROM instructor
    ORDER BY salary ASC
    FETCH FIRST 3 ROWS ONLY
)
ORDER BY salary DESC;

-- Q9
SELECT DISTINCT s.name
FROM student s
WHERE s.ID IN (
    SELECT ID FROM takes
    WHERE semester = 'Fall' AND year = 2009
);

-- Q10
SELECT DISTINCT s.name
FROM student s
WHERE s.ID = SOME (
    SELECT ID FROM takes
    WHERE semester = 'Fall' AND year = 2009
);

-- Q11
SELECT DISTINCT s.name
FROM student s NATURAL INNER JOIN takes t
WHERE t.semester = 'Fall' AND t.year = 2009;

-- Q12
SELECT DISTINCT s.name
FROM student s
WHERE EXISTS (
    SELECT 1 FROM takes t
    WHERE t.ID = s.ID
      AND t.semester = 'Fall'
      AND t.year = 2009
);

-- Q13
SELECT DISTINCT t1.ID AS etud1, t2.ID AS etud2
FROM takes t1, takes t2
WHERE t1.course_id = t2.course_id
  AND t1.sec_id    = t2.sec_id
  AND t1.semester  = t2.semester
  AND t1.year      = t2.year
  AND t1.ID < t2.ID;

-- Q14
SELECT i.name, COUNT(*) AS nb_etudiants
FROM instructor i, teaches te, takes t
WHERE i.ID = te.ID
  AND te.course_id = t.course_id
  AND te.sec_id    = t.sec_id
  AND te.semester  = t.semester
  AND te.year      = t.year
GROUP BY i.ID, i.name
ORDER BY nb_etudiants DESC;

-- Q15
SELECT i.name, COUNT(t.ID) AS nb_etudiants
FROM instructor i
LEFT JOIN teaches te ON i.ID = te.ID
LEFT JOIN takes t
       ON te.course_id = t.course_id
      AND te.sec_id    = t.sec_id
      AND te.semester  = t.semester
      AND te.year      = t.year
GROUP BY i.ID, i.name
ORDER BY nb_etudiants DESC;

-- Q16
SELECT i.name, COUNT(*) AS nb_A
FROM instructor i, teaches te, takes t
WHERE i.ID = te.ID
  AND te.course_id = t.course_id
  AND te.sec_id    = t.sec_id
  AND te.semester  = t.semester
  AND te.year      = t.year
  AND t.grade = 'A'
GROUP BY i.ID, i.name;

-- Q17
SELECT i.name AS prof, s.name AS etudiant, COUNT(*) AS nb_cours
FROM instructor i, teaches te, takes t, student s
WHERE i.ID = te.ID
  AND te.course_id = t.course_id
  AND te.sec_id    = t.sec_id
  AND te.semester  = t.semester
  AND te.year      = t.year
  AND t.ID = s.ID
GROUP BY i.ID, i.name, s.ID, s.name;

-- Q18
SELECT i.name AS prof, s.name AS etudiant, COUNT(*) AS nb_cours
FROM instructor i, teaches te, takes t, student s
WHERE i.ID = te.ID
  AND te.course_id = t.course_id
  AND te.sec_id    = t.sec_id
  AND te.semester  = t.semester
  AND te.year      = t.year
  AND t.ID = s.ID
GROUP BY i.ID, i.name, s.ID, s.name
HAVING COUNT(*) >= 2;
