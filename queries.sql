-- 1. Student-wise total & average marks
SELECT s.student_name,
       SUM(m.marks_obtained) AS total_marks,
       ROUND(AVG(m.marks_obtained), 2) AS average_marks
FROM students s
JOIN marks m ON s.student_id = m.student_id
GROUP BY s.student_name;

-- 2. Grade calculation using CASE
SELECT s.student_name,
       ROUND(AVG(m.marks_obtained), 2) AS avg_marks,
       CASE
           WHEN AVG(m.marks_obtained) >= 75 THEN 'Distinction'
           WHEN AVG(m.marks_obtained) >= 60 THEN 'First Class'
           WHEN AVG(m.marks_obtained) >= 50 THEN 'Second Class'
           ELSE 'Fail'
       END AS grade
FROM students s
JOIN marks m ON s.student_id = m.student_id
GROUP BY s.student_name;

-- 3. Subject-wise average marks
SELECT sub.subject_name,
       ROUND(AVG(m.marks_obtained), 2) AS avg_marks
FROM subjects sub
JOIN marks m ON sub.subject_id = m.subject_id
GROUP BY sub.subject_name;

-- 4. Top performer
SELECT student_name, avg_marks
FROM (
    SELECT s.student_name,
           AVG(m.marks_obtained) AS avg_marks
    FROM students s
    JOIN marks m ON s.student_id = m.student_id
    GROUP BY s.student_name
) t
ORDER BY avg_marks DESC
LIMIT 1;

-- 5. Students below class average
SELECT DISTINCT s.student_name
FROM students s
JOIN marks m ON s.student_id = m.student_id
WHERE m.marks_obtained < (SELECT AVG(marks_obtained) FROM marks);

-- 6. Ranking students (MySQL 8+)
SELECT s.student_name,
       ROUND(AVG(m.marks_obtained), 2) AS avg_marks,
       RANK() OVER (ORDER BY AVG(m.marks_obtained) DESC) AS rank_position
FROM students s
JOIN marks m ON s.student_id = m.student_id
GROUP BY s.student_name;

-- 7. Create VIEW for performance
CREATE VIEW student_performance AS
SELECT s.student_id,
       s.student_name,
       ROUND(AVG(m.marks_obtained), 2) AS average_marks
FROM students s
JOIN marks m ON s.student_id = m.student_id
GROUP BY s.student_id, s.student_name;

-- 8. Distinction students using VIEW
SELECT *
FROM student_performance
WHERE average_marks >= 75;
