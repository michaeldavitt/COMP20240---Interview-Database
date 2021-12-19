-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3310
-- Generation Time: Dec 19, 2021 at 09:47 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `company_interviews`
--

-- --------------------------------------------------------

--
-- Table structure for table `branch`
--

CREATE TABLE `branch` (
  `name` varchar(45) NOT NULL COMMENT 'Branch Name - Name of the branch. Assumes that the branch name is unique. If there are two branches in the same location, they will need to be renamed accordingly (eg: Dublin North and Dublin South)',
  `address` varchar(45) DEFAULT NULL COMMENT 'Branch address - The location of the branch',
  `phone` varchar(45) DEFAULT NULL COMMENT 'Branch Phone Number - Phone number of the branch'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each row represents a branch of the company';

--
-- Dumping data for table `branch`
--

INSERT INTO `branch` (`name`, `address`, `phone`) VALUES
('Barcelona', '21 Puerta Verde, Barcelona, Spain', '0986571234'),
('Berlin', '23 Hazfort Ln, Berlin, Germany', '8765432123'),
('Catanzaro', 'Piazza della Repubblica 133, Catanzaro, Italy', '03333323712'),
('Cork', '43 Avenue Blvd, Cork, Ireland', '0875647384'),
('Dublin', '20 Fairfield Rd, Dublin 16, Ireland', '0876543213'),
('Limerick', '53 Limescale Ave, Limerick, Ireland', '0879584747'),
('London', '21 Hyde Park, London, England', '498765432'),
('Madrid', '32 Calle Roja, Madrid, Spain', '0987654321'),
('Paris', '21 Chanz Elise, Paris, France', '7654739876'),
('Rome', 'Vicolo Calcirelli 56, Rome, Italy', '03325533263');

-- --------------------------------------------------------

--
-- Table structure for table `candidate`
--

CREATE TABLE `candidate` (
  `idcandidate` int(11) NOT NULL COMMENT 'Candidate ID - Uniquely identifies candidates looking for employment in the organisation',
  `firstname` varchar(45) NOT NULL COMMENT 'Candidate''s first name',
  `surname` varchar(45) NOT NULL COMMENT 'Candidate''s surname',
  `phone` varchar(45) DEFAULT NULL COMMENT 'Candidate''s phone number',
  `address` varchar(45) DEFAULT NULL COMMENT 'Address - Primary address of the candidate'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each row represents a candidate seeking work in the organisation';

--
-- Dumping data for table `candidate`
--

INSERT INTO `candidate` (`idcandidate`, `firstname`, `surname`, `phone`, `address`) VALUES
(1, 'Donagh', 'McDonnell', '0209195040', '26 South Bank, Cork, Ireland'),
(2, 'Ossian', 'Gallagher', '0209140937', '10 High St, Cork, Ireland'),
(3, 'Brendan', 'O\'Ryan', '0209177870', '4 Clarence St, Antrim, Ireland'),
(4, 'Lorcan', 'Flanigan', '0209191748', '13 Whitechurch Ave, Dublin, Ireland'),
(5, 'Mick', 'Guinness', '0209144086', '1 Thornhill View, Dublin, Ireland'),
(6, 'Maura', 'O\'Reilly', '0209135976', '29 Magherabeg Rd, Antrim, Ireland'),
(7, 'Mary', 'Brennan', '0209133230', '6 Upr. Edward St, Down, Ireland'),
(8, 'Eileen', 'McShane', '0209118215', '12 Douglas St, Cork, Ireland'),
(9, 'Grania', 'McGlinchy', '0209179103', '32 Fr. Griffin Rd, Galway, Ireland'),
(10, 'Eileen', 'McDermott', '0209193402', '8 Ruskin Heights, Antrim, Ireland'),
(11, 'Gerald', 'Finch', '0873241234', '20 Park Road, Ennis, Clare, Ireland');

-- --------------------------------------------------------

--
-- Table structure for table `candidate_skills`
--

CREATE TABLE `candidate_skills` (
  `idcandidate` int(11) NOT NULL COMMENT 'Candidate ID - Foreign key that references the candidate table',
  `skill` varchar(45) NOT NULL COMMENT 'Skill Name - Foreign key that links to the skills table'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each row represents a skill that a particular candidate posesses';

--
-- Dumping data for table `candidate_skills`
--

INSERT INTO `candidate_skills` (`idcandidate`, `skill`) VALUES
(1, 'Bash'),
(1, 'Python'),
(2, 'Python'),
(3, 'Administrative'),
(3, 'Teamwork'),
(4, 'Leadership'),
(5, 'PHP'),
(6, 'Communication'),
(6, 'JavaScript'),
(10, 'Communication'),
(10, 'Leadership'),
(10, 'Python'),
(10, 'Teamwork');

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `iddepartment` int(11) NOT NULL COMMENT 'Department ID - Uniquely identifies a department',
  `name` varchar(45) NOT NULL COMMENT 'Name of the department',
  `branch_name` varchar(45) NOT NULL COMMENT 'Branch ID - The branch that the deparment is in. Foreign key referencing the branch table'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each row represents a department in the organisation';

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`iddepartment`, `name`, `branch_name`) VALUES
(13, 'Accounting and Finance', 'Barcelona'),
(10, 'Accounting and Finance', 'Cork'),
(5, 'Accounting and Finance', 'Dublin'),
(11, 'Human Resources', 'Cork'),
(4, 'Human Resources', 'Dublin'),
(9, 'Marketing', 'Cork'),
(3, 'Marketing', 'Dublin'),
(7, 'Production', 'Cork'),
(2, 'Production', 'Dublin'),
(12, 'Purchasing', 'Cork'),
(6, 'Purchasing', 'Dublin'),
(14, 'Research and Development', 'Barcelona'),
(8, 'Research and Development', 'Cork'),
(1, 'Research and Development', 'Dublin');

-- --------------------------------------------------------

--
-- Table structure for table `interview`
--

CREATE TABLE `interview` (
  `idInterview` int(11) NOT NULL COMMENT 'Interview ID - To uniquely identify each interview',
  `idcandidate` int(11) NOT NULL COMMENT 'Candidate ID - Foreign key to the Candidates table',
  `iddepartment` int(11) NOT NULL COMMENT 'Department ID - Foreign key to the Departments table',
  `idposition` int(11) NOT NULL COMMENT 'Position ID - Foreign key referencing the Positions table',
  `date` date DEFAULT NULL COMMENT 'Date at which the interview took place',
  `result` varchar(45) DEFAULT NULL COMMENT 'Outcome of the interview - Can be Accepted, Rejected or Null (indicating that a decision has not yet been made)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each row represents an interview that has either taken place or will take place in the future';

--
-- Dumping data for table `interview`
--

INSERT INTO `interview` (`idInterview`, `idcandidate`, `iddepartment`, `idposition`, `date`, `result`) VALUES
(1, 6, 6, 1, '2021-09-28', 'Accepted'),
(2, 10, 6, 2, '2022-01-01', ''),
(3, 2, 6, 2, '2020-12-31', 'Rejected'),
(4, 5, 6, 3, '2020-12-12', 'Accepted'),
(5, 7, 4, 10, '2021-01-01', 'Rejected'),
(6, 8, 10, 5, '2022-01-01', NULL),
(7, 2, 2, 6, '2020-01-01', 'Rejected'),
(8, 3, 9, 8, '2022-01-02', NULL),
(9, 4, 1, 9, '2021-03-02', 'Accepted'),
(10, 10, 6, 1, '2020-10-10', 'Rejected'),
(11, 10, 10, 5, '2020-09-01', 'Rejected'),
(12, 3, 4, 5, '2022-01-01', 'Rejected'),
(13, 1, 1, 1, '2022-01-01', 'Rejected'),
(14, 6, 7, 2, '2020-12-31', 'Rejected'),
(15, 1, 6, 1, '2022-01-01', NULL),
(16, 3, 9, 7, '2021-12-07', 'Rejected'),
(17, 3, 9, 7, '2021-12-07', 'Rejected'),
(18, 4, 10, 1, '2021-12-10', 'Accepted'),
(19, 9, 14, 10, '2021-12-01', 'Rejected');

-- --------------------------------------------------------

--
-- Table structure for table `position`
--

CREATE TABLE `position` (
  `idposition` int(11) NOT NULL COMMENT 'Position ID - Uniquely identifies each position being offered',
  `iddepartment` int(11) NOT NULL COMMENT 'Department ID - Foreign key which references the departments table',
  `type` varchar(45) DEFAULT NULL COMMENT 'Type of position being offered',
  `Salary` int(11) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each row represents a position being offered by the organisation';

--
-- Dumping data for table `position`
--

INSERT INTO `position` (`idposition`, `iddepartment`, `type`, `Salary`, `description`) VALUES
(1, 6, 'Internship', 20000, 'Fulfill tasks set out by supervisors from several departments. Attend meetings and take minutes. Perform research at a supervisor\'s request. Update social media platforms and write copy for posts.'),
(2, 6, 'Graduate Role', 40000, 'Review and process purchase requisitions for indirect goods and services supporting HR and IT categories. Work with internal stakeholders to expedite purchasing requests.'),
(3, 6, 'Managerial Role', 90000, 'Responsible for planning, directing, and overseeing the operations and fiscal health of a business unit, division, department, or operating unit within an organization. Responsible for overseeing and leading the work of a group of people in many instances'),
(4, 1, 'Managerial Role', 70000, 'Responsible for planning, directing, and overseeing the operations and fiscal health of a business unit, division, department, or operating unit within an organization. Responsible for overseeing and leading the work of a group of people in many instances'),
(5, 10, 'Senior Role', 60000, 'Responsible for planning and directing the work of a group of individuals. Monitor work and take corrective actions when necessary.'),
(6, 2, 'Internship', 22000, 'Fulfill tasks set out by supervisors from several departments. Attend meetings and take minutes. Perform research at a supervisor\'s request. Update social media platforms and write copy for posts.'),
(7, 3, 'Graduate Role', 35000, 'Review and process purchase requisitions for indirect goods and services supporting HR and IT categories. Work with internal stakeholders to expedite purchasing requests.'),
(8, 9, 'Senior Role', 55000, 'Responsible for planning and directing the work of a group of individuals. Monitor work and take corrective actions when necessary.'),
(9, 1, 'Directorial Role', 100000, 'Responsible for all aspects of the company\'s success. Administer organizational activities, set business strategies, delegate tasks, and recruit new managerial employees. Report to board members or company stakeholders.'),
(10, 4, 'Managerial Role', 85000, 'Responsible for planning, directing, and overseeing the operations and fiscal health of a business unit, division, department, or operating unit within an organization. Responsible for overseeing and leading the work of a group of people in many instances'),
(11, 7, 'Managerial Role', 80000, 'Responsible for planning, directing, and overseeing the operations and fiscal health of a business unit, division, department, or operating unit within an organization. Responsible for overseeing and leading the work of a group of people in many instances'),
(12, 8, 'Managerial Role', 75000, 'Responsible for planning, directing, and overseeing the operations and fiscal health of a business unit, division, department, or operating unit within an organization. Responsible for overseeing and leading the work of a group of people in many instances');

-- --------------------------------------------------------

--
-- Table structure for table `position_skills`
--

CREATE TABLE `position_skills` (
  `idposition` int(11) NOT NULL COMMENT 'Position ID - Foreign Key that references the position table',
  `skill` varchar(45) NOT NULL COMMENT 'Skill Name - Foreign key that references the skills table'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each row represents a skill that a particular position requires';

--
-- Dumping data for table `position_skills`
--

INSERT INTO `position_skills` (`idposition`, `skill`) VALUES
(1, 'Administrative'),
(1, 'Teamwork'),
(2, 'Bash'),
(2, 'PHP'),
(2, 'Python'),
(3, 'Administrative'),
(4, 'Python'),
(7, 'Administrative'),
(7, 'Leadership'),
(8, 'Communication'),
(8, 'JavaScript'),
(8, 'Leadership'),
(10, 'Bash'),
(10, 'Leadership'),
(10, 'Python');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `branch`
--
ALTER TABLE `branch`
  ADD PRIMARY KEY (`name`),
  ADD UNIQUE KEY `address_UNIQUE` (`address`);

--
-- Indexes for table `candidate`
--
ALTER TABLE `candidate`
  ADD PRIMARY KEY (`idcandidate`);

--
-- Indexes for table `candidate_skills`
--
ALTER TABLE `candidate_skills`
  ADD PRIMARY KEY (`idcandidate`,`skill`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`iddepartment`),
  ADD UNIQUE KEY `UNIQUE` (`name`,`branch_name`),
  ADD KEY `dep_to_branch_idx` (`branch_name`);

--
-- Indexes for table `interview`
--
ALTER TABLE `interview`
  ADD PRIMARY KEY (`idInterview`),
  ADD KEY `interview_to_department_idx` (`iddepartment`),
  ADD KEY `interview_to_position_idx` (`idposition`),
  ADD KEY `interview_to_candidate_idx` (`idcandidate`);

--
-- Indexes for table `position`
--
ALTER TABLE `position`
  ADD PRIMARY KEY (`idposition`),
  ADD KEY `position_to_department_idx` (`iddepartment`);

--
-- Indexes for table `position_skills`
--
ALTER TABLE `position_skills`
  ADD PRIMARY KEY (`idposition`,`skill`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `candidate_skills`
--
ALTER TABLE `candidate_skills`
  ADD CONSTRAINT `cskills_to_candidate` FOREIGN KEY (`idcandidate`) REFERENCES `candidate` (`idcandidate`) ON UPDATE CASCADE;

--
-- Constraints for table `department`
--
ALTER TABLE `department`
  ADD CONSTRAINT `dep_to_branch` FOREIGN KEY (`branch_name`) REFERENCES `branch` (`name`) ON UPDATE CASCADE;

--
-- Constraints for table `interview`
--
ALTER TABLE `interview`
  ADD CONSTRAINT `interview_to_candidate` FOREIGN KEY (`idcandidate`) REFERENCES `candidate` (`idcandidate`) ON UPDATE CASCADE,
  ADD CONSTRAINT `interview_to_department` FOREIGN KEY (`iddepartment`) REFERENCES `department` (`iddepartment`) ON UPDATE CASCADE,
  ADD CONSTRAINT `interview_to_position` FOREIGN KEY (`idposition`) REFERENCES `position` (`idposition`) ON UPDATE CASCADE;

--
-- Constraints for table `position`
--
ALTER TABLE `position`
  ADD CONSTRAINT `position_to_department` FOREIGN KEY (`iddepartment`) REFERENCES `department` (`iddepartment`) ON UPDATE CASCADE;

--
-- Constraints for table `position_skills`
--
ALTER TABLE `position_skills`
  ADD CONSTRAINT `ps_to_position` FOREIGN KEY (`idposition`) REFERENCES `position` (`idposition`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
