-- Create Database
CREATE DATABASE student_result_db;
USE student_result_db;

-- Students Table
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    gender CHAR(1),
    date_of_birth DATE,
    course VARCHAR(50),
    admission_year INT
);

-- Subjects Table
CREATE TABLE subjects (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(50),
    max_marks INT
);

-- Marks Table
CREATE TABLE marks (
    mark_id INT PRIMARY KEY,
    student_id INT,
    subject_id INT,
    marks_obtained INT,
    exam_date DATE,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);
