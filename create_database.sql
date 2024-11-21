CREATE DATABASE schoolManagement;


-- Create the multiple tables that will be needed

CREATE TABLE student(
    studentId INT AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    age TINYINT UNSIGNED,
    gradeLevel VARCHAR(10),
    enrollmentDate DATE,
    PRIMARY KEY(studentId)
);

CREATE TABLE subject(
  subjectId INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(25),
  description TEXT,
  PRIMARY KEY (subjectId)
);

CREATE TABLE teacher(
  teacherId INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL ,
  hireDate DATE,
  subjectId INT,
  PRIMARY KEY (teacherId),
  FOREIGN KEY (subjectId) REFERENCES subject(subjectId)
);

CREATE TABLE class(
    classId INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL ,
    schedule VARCHAR(50),
    teacherId INT,
    subjectId INT,
    PRIMARY KEY (classId),
    FOREIGN KEY (teacherId) REFERENCES teacher(teacherId),
    FOREIGN KEY (subjectId) REFERENCES subject(subjectId)
);

CREATE TABLE grade(
    gradeId INT AUTO_INCREMENT,
    studentId INT,
    classId INT,
    grade CHAR(1) CHECK (grade IN ('A', 'B', 'C', 'D', 'E','F')),
    date DATE,
    PRIMARY KEY (gradeId),
    FOREIGN KEY (studentId) REFERENCES student(studentId),
    FOREIGN KEY (classId) REFERENCES class(classId)

);

-- Seeding the database so that we can do som querying

INSERT INTO subject (name, description) VALUES
('Mathematics', 'Study of numbers, equations, and geometry'),
('Science', 'Exploration of the natural world through experiments'),
('History', 'Study of past events and civilizations'),
('English', 'Focus on language, literature, and writing skills'),
('Art', 'Study and creation of visual works of art');

INSERT INTO teacher (name, hireDate, subjectId) VALUES
('Johan', '2015-08-15', 1),  -- Mathematics
('Elin', '2018-01-10', 2), -- Science
('Oskar', '2010-06-25', 3), -- History
('Anna', '2020-03-12', 4), -- English
('Lina', '2017-11-08', 5); -- Art

-- Insert into Students
INSERT INTO student (name, age, gradeLevel, enrollmentDate) VALUES
('Emil', 16, '10th', '2022-09-01'),
('Maja', 17, '11th', '2021-09-01'),
('Axel', 15, '9th', '2023-09-01'),
('Ella', 16, '10th', '2022-09-01'),
('Alma', 14, '8th', '2023-09-01');

INSERT INTO class (name, schedule, teacherId, subjectId)
VALUES
    ('Mathematics 101', 'Mon 10:00 AM', 1, 1),  -- Class for Mathematics (subject_id = 1) with Teacher 1
    ('Mathematics 102', 'Wed 2:00 PM', 2, 1),  -- Another class for Mathematics (subject_id = 1) with Teacher 2
    ('English 101', 'Tue 9:00 AM', 3, 2),      -- Class for English (subject_id = 2) with Teacher 3
    ('History 101', 'Fri 1:00 PM', 4, 3),      -- Class for History (subject_id = 3) with Teacher 4
    ('Science 101', 'Mon 12:00 PM', 5, 4);     -- Class for Biology (subject_id = 4) with Teacher 5


INSERT INTO grade (studentId, classId, grade, date) VALUES
(1, 1, 'A', '2024-11-01'), -- Elin in Algebra 101
(1, 2, 'B', '2024-11-02'), -- Elin in Biology 201
(2, 3, 'C', '2024-11-03'), -- William in World History
(3, 4, 'A', '2024-11-04'), -- Maja in English Literature
(4, 5, 'B', '2024-11-05'), -- Oscar in Painting Basics
(5, 1, 'C', '2024-11-01'), -- Astrid in Algebra 101
(5, 2, 'B', '2024-11-02'); -- Astrid in Biology 201


-- In this query we will grab the classes with the teacher that will lead each class
SELECT
    c.classId AS ClassID,
    c.name AS ClassName,
    c.schedule as Schedule,
    t.name AS TeacherName,
    s.name AS SubjectName
FROM
    class c
INNER JOIN teacher t ON c.teacherId = t.teacherId
INNER JOIN subject s ON c.subjectId = s.subjectId
ORDER BY schedule;

-- Create a view where we more easily can retrieve students grades
CREATE VIEW StudentGrades AS
SELECT
    s.studentId AS StudentID,
    s.name AS StudentName,
    c.name AS ClassName,
    g.grade AS Grade,
    g.date AS GradeDate
FROM
    grade g
JOIN student s ON g.studentId = s.studentId
JOIN class c ON g.classId = c.classId;

-- Retrieve the data from the view we created before
SELECT * FROM StudentGrades;

-- Removes the entire database
DROP DATABASE schoolManagement;
