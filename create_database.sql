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


INSERT INTO grade (studentId, classId, grade, date) VALUES
(1, 1, 'A', '2024-11-01'), -- Elin in Algebra 101
(1, 2, 'B', '2024-11-02'), -- Elin in Biology 201
(2, 3, 'C', '2024-11-03'), -- William in World History
(3, 4, 'A', '2024-11-04'), -- Maja in English Literature
(4, 5, 'B', '2024-11-05'), -- Oscar in Painting Basics
(5, 1, 'C', '2024-11-01'), -- Astrid in Algebra 101
(5, 2, 'B', '2024-11-02'); -- Astrid in Biology 201

-- Removes the entire database
DROP DATABASE schoolManagement;
