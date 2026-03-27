 
CREATE TABLE classroom (
    building    VARCHAR2(15),
    room_number VARCHAR2(7),
    capacity    NUMBER(4),
    CONSTRAINT pk_classroom PRIMARY KEY (building, room_number)
);
 
CREATE TABLE department (
    dept_name VARCHAR2(20),
    building  VARCHAR2(15),
    budget    NUMBER(12,2),
    CONSTRAINT pk_department PRIMARY KEY (dept_name)
);
 
CREATE TABLE course (
    course_id VARCHAR2(8),
    title     VARCHAR2(50),
    dept_name VARCHAR2(20),
    credits   NUMBER(2),
    CONSTRAINT pk_course     PRIMARY KEY (course_id),
    CONSTRAINT fk_course_dep FOREIGN KEY (dept_name) REFERENCES department(dept_name)
);
 
CREATE TABLE instructor (
    ID        VARCHAR2(5),
    name      VARCHAR2(20)  NOT NULL,
    dept_name VARCHAR2(20),
    salary    NUMBER(8,2),
    CONSTRAINT pk_instructor     PRIMARY KEY (ID),
    CONSTRAINT fk_instr_dep      FOREIGN KEY (dept_name) REFERENCES department(dept_name)
);
 
CREATE TABLE time_slot (
    time_slot_id VARCHAR2(4),
    day          VARCHAR2(1),
    start_time   DATE,
    end_time     DATE,
    CONSTRAINT pk_time_slot PRIMARY KEY (time_slot_id, day, start_time)
);
 
CREATE TABLE section (
    course_id    VARCHAR2(8),
    sec_id       VARCHAR2(8),
    semester     VARCHAR2(6),
    year         NUMBER(4),
    building     VARCHAR2(15),
    room_number  VARCHAR2(7),
    time_slot_id VARCHAR2(4),
    CONSTRAINT pk_section      PRIMARY KEY (course_id, sec_id, semester, year),
    CONSTRAINT fk_sec_course   FOREIGN KEY (course_id)             REFERENCES course(course_id),
    CONSTRAINT fk_sec_room     FOREIGN KEY (building, room_number) REFERENCES classroom(building, room_number),
    CONSTRAINT chk_semester    CHECK (semester IN ('Fall', 'Winter', 'Spring', 'Summer'))
);
 
CREATE TABLE student (
    ID        VARCHAR2(5),
    name      VARCHAR2(20) NOT NULL,
    dept_name VARCHAR2(20),
    tot_cred  NUMBER(3),
    CONSTRAINT pk_student    PRIMARY KEY (ID),
    CONSTRAINT fk_stu_dep    FOREIGN KEY (dept_name) REFERENCES department(dept_name)
);
 
CREATE TABLE takes (
    ID        VARCHAR2(5),
    course_id VARCHAR2(8),
    sec_id    VARCHAR2(8),
    semester  VARCHAR2(6),
    year      NUMBER(4),
    grade     VARCHAR2(2),
    CONSTRAINT pk_takes      PRIMARY KEY (ID, course_id, sec_id, semester, year),
    CONSTRAINT fk_takes_stu  FOREIGN KEY (ID)                              REFERENCES student(ID),
    CONSTRAINT fk_takes_sec  FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES section(course_id, sec_id, semester, year)
);
 
CREATE TABLE teaches (
    ID        VARCHAR2(5),
    course_id VARCHAR2(8),
    sec_id    VARCHAR2(8),
    semester  VARCHAR2(6),
    year      NUMBER(4),
    CONSTRAINT pk_teaches      PRIMARY KEY (ID, course_id, sec_id, semester, year),
    CONSTRAINT fk_teaches_instr FOREIGN KEY (ID)                               REFERENCES instructor(ID),
    CONSTRAINT fk_teaches_sec   FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES section(course_id, sec_id, semester, year)
);
 
CREATE TABLE prereq (
    course_id VARCHAR2(8),
    prereq_id VARCHAR2(8),
    CONSTRAINT pk_prereq       PRIMARY KEY (course_id, prereq_id),
    CONSTRAINT fk_prereq_c     FOREIGN KEY (course_id) REFERENCES course(course_id),
    CONSTRAINT fk_prereq_pre   FOREIGN KEY (prereq_id) REFERENCES course(course_id)
);
 
CREATE TABLE advisor (
    s_id VARCHAR2(5),
    i_id VARCHAR2(5),
    CONSTRAINT pk_advisor    PRIMARY KEY (s_id),
    CONSTRAINT fk_adv_stu    FOREIGN KEY (s_id) REFERENCES student(ID),
    CONSTRAINT fk_adv_instr  FOREIGN KEY (i_id) REFERENCES instructor(ID)
);
 
 

 

INSERT INTO classroom VALUES ('Packard',  '101', 500);
INSERT INTO classroom VALUES ('Painter',  '514', 10);
INSERT INTO classroom VALUES ('Taylor',   '3128', 70);
INSERT INTO classroom VALUES ('Watson',   '100', 30);
INSERT INTO classroom VALUES ('Watson',   '120', 50);
 

INSERT INTO department VALUES ('Biology',    'Watson',  90000);
INSERT INTO department VALUES ('Comp. Sci.', 'Taylor',  100000);
INSERT INTO department VALUES ('Elec. Eng.', 'Taylor',  85000);
INSERT INTO department VALUES ('Finance',    'Painter', 120000);
INSERT INTO department VALUES ('History',    'Painter', 50000);
INSERT INTO department VALUES ('Music',      'Packard', 80000);
INSERT INTO department VALUES ('Physics',    'Watson',  70000);
 

INSERT INTO course VALUES ('BIO-101', 'Intro. to Biology',          'Biology',    4);
INSERT INTO course VALUES ('BIO-301', 'Genetics',                   'Biology',    4);
INSERT INTO course VALUES ('BIO-399', 'Computational Biology',      'Biology',    3);
INSERT INTO course VALUES ('CS-101',  'Intro. to Computer Science', 'Comp. Sci.', 4);
INSERT INTO course VALUES ('CS-190',  'Game Design',                'Comp. Sci.', 4);
INSERT INTO course VALUES ('CS-315',  'Robotics',                   'Comp. Sci.', 3);
INSERT INTO course VALUES ('CS-319',  'Image Processing',           'Comp. Sci.', 3);
INSERT INTO course VALUES ('CS-347',  'Database System Concepts',   'Comp. Sci.', 3);
INSERT INTO course VALUES ('EE-181',  'Intro. to Digital Systems',  'Elec. Eng.', 3);
INSERT INTO course VALUES ('FIN-201', 'Investment Banking',         'Finance',    3);
INSERT INTO course VALUES ('HIS-351', 'World History',              'History',    3);
INSERT INTO course VALUES ('MU-199',  'Music Video Production',     'Music',      3);
INSERT INTO course VALUES ('PHY-101', 'Physical Principles',        'Physics',    4);
 

INSERT INTO instructor VALUES ('10101', 'Srinivasan', 'Comp. Sci.', 65000);
INSERT INTO instructor VALUES ('12121', 'Wu',         'Finance',    90000);
INSERT INTO instructor VALUES ('15151', 'Mozart',     'Music',      40000);
INSERT INTO instructor VALUES ('22222', 'Einstein',   'Physics',    95000);
INSERT INTO instructor VALUES ('32343', 'El Said',    'History',    60000);
INSERT INTO instructor VALUES ('33456', 'Gold',       'Physics',    87000);
INSERT INTO instructor VALUES ('45565', 'Katz',       'Comp. Sci.', 75000);
INSERT INTO instructor VALUES ('58583', 'Califieri',  'History',    62000);
INSERT INTO instructor VALUES ('76543', 'Singh',      'Finance',    80000);
INSERT INTO instructor VALUES ('76766', 'Crick',      'Biology',    72000);
INSERT INTO instructor VALUES ('83821', 'Brandt',     'Comp. Sci.', 92000);
INSERT INTO instructor VALUES ('98345', 'Kim',        'Elec. Eng.', 80000);
 

INSERT INTO time_slot VALUES ('A', 'M', TO_DATE('08:00','HH24:MI'), TO_DATE('08:50','HH24:MI'));
INSERT INTO time_slot VALUES ('A', 'W', TO_DATE('08:00','HH24:MI'), TO_DATE('08:50','HH24:MI'));
INSERT INTO time_slot VALUES ('A', 'F', TO_DATE('08:00','HH24:MI'), TO_DATE('08:50','HH24:MI'));
INSERT INTO time_slot VALUES ('B', 'M', TO_DATE('09:00','HH24:MI'), TO_DATE('09:50','HH24:MI'));
INSERT INTO time_slot VALUES ('B', 'W', TO_DATE('09:00','HH24:MI'), TO_DATE('09:50','HH24:MI'));
INSERT INTO time_slot VALUES ('B', 'F', TO_DATE('09:00','HH24:MI'), TO_DATE('09:50','HH24:MI'));
INSERT INTO time_slot VALUES ('C', 'M', TO_DATE('11:00','HH24:MI'), TO_DATE('11:50','HH24:MI'));
INSERT INTO time_slot VALUES ('C', 'W', TO_DATE('11:00','HH24:MI'), TO_DATE('11:50','HH24:MI'));
INSERT INTO time_slot VALUES ('C', 'F', TO_DATE('11:00','HH24:MI'), TO_DATE('11:50','HH24:MI'));
INSERT INTO time_slot VALUES ('D', 'M', TO_DATE('13:00','HH24:MI'), TO_DATE('13:50','HH24:MI'));
INSERT INTO time_slot VALUES ('D', 'W', TO_DATE('13:00','HH24:MI'), TO_DATE('13:50','HH24:MI'));
INSERT INTO time_slot VALUES ('D', 'F', TO_DATE('13:00','HH24:MI'), TO_DATE('13:50','HH24:MI'));
INSERT INTO time_slot VALUES ('E', 'T', TO_DATE('10:30','HH24:MI'), TO_DATE('11:45','HH24:MI'));
INSERT INTO time_slot VALUES ('E', 'R', TO_DATE('10:30','HH24:MI'), TO_DATE('11:45','HH24:MI'));
INSERT INTO time_slot VALUES ('F', 'T', TO_DATE('14:30','HH24:MI'), TO_DATE('15:45','HH24:MI'));
INSERT INTO time_slot VALUES ('F', 'R', TO_DATE('14:30','HH24:MI'), TO_DATE('15:45','HH24:MI'));
INSERT INTO time_slot VALUES ('G', 'M', TO_DATE('16:00','HH24:MI'), TO_DATE('16:50','HH24:MI'));
INSERT INTO time_slot VALUES ('G', 'W', TO_DATE('16:00','HH24:MI'), TO_DATE('16:50','HH24:MI'));
INSERT INTO time_slot VALUES ('G', 'F', TO_DATE('16:00','HH24:MI'), TO_DATE('16:50','HH24:MI'));
INSERT INTO time_slot VALUES ('H', 'W', TO_DATE('10:00','HH24:MI'), TO_DATE('12:30','HH24:MI'));
 

INSERT INTO section VALUES ('BIO-101', '1', 'Summer', 2009, 'Painter',  '514',  'B');
INSERT INTO section VALUES ('BIO-301', '1', 'Summer', 2010, 'Painter',  '514',  'A');
INSERT INTO section VALUES ('CS-101',  '1', 'Fall',   2009, 'Packard',  '101',  'H');
INSERT INTO section VALUES ('CS-101',  '1', 'Spring', 2010, 'Packard',  '101',  'F');
INSERT INTO section VALUES ('CS-190',  '1', 'Spring', 2009, 'Taylor',   '3128', 'E');
INSERT INTO section VALUES ('CS-190',  '2', 'Spring', 2009, 'Taylor',   '3128', 'A');
INSERT INTO section VALUES ('CS-315',  '1', 'Spring', 2010, 'Watson',   '120',  'D');
INSERT INTO section VALUES ('CS-319',  '1', 'Spring', 2010, 'Watson',   '100',  'B');
INSERT INTO section VALUES ('CS-319',  '2', 'Spring', 2010, 'Taylor',   '3128', 'C');
INSERT INTO section VALUES ('CS-347',  '1', 'Fall',   2009, 'Taylor',   '3128', 'A');
INSERT INTO section VALUES ('EE-181',  '1', 'Spring', 2009, 'Taylor',   '3128', 'C');
INSERT INTO section VALUES ('FIN-201', '1', 'Spring', 2010, 'Packard',  '101',  'B');
INSERT INTO section VALUES ('HIS-351', '1', 'Spring', 2010, 'Painter',  '514',  'C');
INSERT INTO section VALUES ('MU-199',  '1', 'Spring', 2010, 'Packard',  '101',  'D');
INSERT INTO section VALUES ('PHY-101', '1', 'Fall',   2009, 'Watson',   '100',  'A');
 

INSERT INTO teaches VALUES ('10101', 'CS-101',  '1', 'Fall',   2009);
INSERT INTO teaches VALUES ('10101', 'CS-315',  '1', 'Spring', 2010);
INSERT INTO teaches VALUES ('10101', 'CS-347',  '1', 'Fall',   2009);
INSERT INTO teaches VALUES ('12121', 'FIN-201', '1', 'Spring', 2010);
INSERT INTO teaches VALUES ('15151', 'MU-199',  '1', 'Spring', 2010);
INSERT INTO teaches VALUES ('22222', 'PHY-101', '1', 'Fall',   2009);
INSERT INTO teaches VALUES ('32343', 'HIS-351', '1', 'Spring', 2010);
INSERT INTO teaches VALUES ('45565', 'CS-101',  '1', 'Spring', 2010);
INSERT INTO teaches VALUES ('45565', 'CS-319',  '1', 'Spring', 2010);
INSERT INTO teaches VALUES ('76766', 'BIO-101', '1', 'Summer', 2009);
INSERT INTO teaches VALUES ('76766', 'BIO-301', '1', 'Summer', 2010);
INSERT INTO teaches VALUES ('83821', 'CS-190',  '1', 'Spring', 2009);
INSERT INTO teaches VALUES ('83821', 'CS-190',  '2', 'Spring', 2009);
INSERT INTO teaches VALUES ('83821', 'CS-319',  '2', 'Spring', 2010);
INSERT INTO teaches VALUES ('98345', 'EE-181',  '1', 'Spring', 2009);
 

INSERT INTO student VALUES ('00128', 'Zhang',     'Comp. Sci.', 102);
INSERT INTO student VALUES ('12345', 'Shankar',   'Comp. Sci.', 32);
INSERT INTO student VALUES ('19991', 'Brandt',    'History',    80);
INSERT INTO student VALUES ('23121', 'Chavez',    'Finance',    110);
INSERT INTO student VALUES ('44553', 'Peltier',   'Physics',    56);
INSERT INTO student VALUES ('45678', 'Levy',      'Physics',    46);
INSERT INTO student VALUES ('54321', 'Williams',  'Comp. Sci.', 54);
INSERT INTO student VALUES ('55739', 'Sanchez',   'Music',      38);
INSERT INTO student VALUES ('70557', 'Snow',      'Physics',    0);
INSERT INTO student VALUES ('76543', 'Brown',     'Comp. Sci.', 58);
INSERT INTO student VALUES ('76653', 'Aoi',       'Elec. Eng.', 60);
INSERT INTO student VALUES ('98765', 'Bourikas',  'Elec. Eng.', 98);
INSERT INTO student VALUES ('98988', 'Tanaka',    'Biology',    120);
 

INSERT INTO takes VALUES ('00128', 'CS-101',  '1', 'Fall',   2009, 'A');
INSERT INTO takes VALUES ('00128', 'CS-347',  '1', 'Fall',   2009, 'A-');
INSERT INTO takes VALUES ('12345', 'CS-101',  '1', 'Fall',   2009, 'C');
INSERT INTO takes VALUES ('12345', 'CS-190',  '2', 'Spring', 2009, 'A');
INSERT INTO takes VALUES ('12345', 'CS-315',  '1', 'Spring', 2010, 'A');
INSERT INTO takes VALUES ('12345', 'CS-347',  '1', 'Fall',   2009, 'A');
INSERT INTO takes VALUES ('19991', 'HIS-351', '1', 'Spring', 2010, 'B');
INSERT INTO takes VALUES ('19991', 'MU-199',  '1', 'Spring', 2010, 'A-');
INSERT INTO takes VALUES ('23121', 'FIN-201', '1', 'Spring', 2010, 'C+');
INSERT INTO takes VALUES ('44553', 'PHY-101', '1', 'Fall',   2009, 'B-');
INSERT INTO takes VALUES ('45678', 'CS-101',  '1', 'Fall',   2009, 'F');
INSERT INTO takes VALUES ('45678', 'CS-101',  '1', 'Spring', 2010, 'B+');
INSERT INTO takes VALUES ('45678', 'CS-319',  '1', 'Spring', 2010, 'B');
INSERT INTO takes VALUES ('54321', 'CS-101',  '1', 'Fall',   2009, 'A-');
INSERT INTO takes VALUES ('54321', 'CS-190',  '2', 'Spring', 2009, 'B+');
INSERT INTO takes VALUES ('55739', 'MU-199',  '1', 'Spring', 2010, 'A');
INSERT INTO takes VALUES ('76543', 'CS-101',  '1', 'Fall',   2009, 'A');
INSERT INTO takes VALUES ('76543', 'CS-319',  '2', 'Spring', 2010, 'A');
INSERT INTO takes VALUES ('76653', 'EE-181',  '1', 'Spring', 2009, 'C');
INSERT INTO takes VALUES ('98765', 'CS-101',  '1', 'Fall',   2009, 'C-');
INSERT INTO takes VALUES ('98765', 'CS-101',  '1', 'Spring', 2010, 'A');
INSERT INTO takes VALUES ('98988', 'BIO-101', '1', 'Summer', 2009, 'A');
INSERT INTO takes VALUES ('98988', 'BIO-301', '1', 'Summer', 2010, NULL);
 

INSERT INTO prereq VALUES ('BIO-301', 'BIO-101');
INSERT INTO prereq VALUES ('BIO-399', 'BIO-101');
INSERT INTO prereq VALUES ('CS-190',  'CS-101');
INSERT INTO prereq VALUES ('CS-315',  'CS-101');
INSERT INTO prereq VALUES ('CS-319',  'CS-101');
INSERT INTO prereq VALUES ('CS-347',  'CS-101');
INSERT INTO prereq VALUES ('EE-181',  'PHY-101');
 

INSERT INTO advisor VALUES ('00128', '45565');
INSERT INTO advisor VALUES ('12345', '10101');
INSERT INTO advisor VALUES ('23121', '76543');
INSERT INTO advisor VALUES ('44553', '22222');
INSERT INTO advisor VALUES ('45678', '22222');
INSERT INTO advisor VALUES ('76543', '45565');
INSERT INTO advisor VALUES ('76653', '98345');
INSERT INTO advisor VALUES ('98765', '98345');
INSERT INTO advisor VALUES ('98988', '76766');
 
COMMIT;
