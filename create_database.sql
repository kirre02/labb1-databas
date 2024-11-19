CREATE DATABASE schoolManagement;


-- Create the mutliple tables that will be needed
CREATE TABLE subject(
  subjectId INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(25)
  PRIMARY KEY (subjectId)
);

CREATE TABLE teacher(
  teacherId INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(50),
  hireDate DATE,
  subjectId INT,
  PRIMARY KEY (teacherId),
  FOREIGN KEY (subjectId) REFERENCES amne(subjectId)
);