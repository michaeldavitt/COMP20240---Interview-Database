# COMP20240: Interview Database

## Instructions
This project assumes that you have a web server solution stack package like XAMPP installed. Once you have cloned this repository, launch the server and the database. Create a new database called company_interviews and import the company_interviews.sql file to gain access to the data used in this site. Run the project repository on the server and you should be greeted with the homepage, which displays interviews for the fictional company SalesCorp

## Material Reference
The database featured on this site was designed as part of the UCD module COMP20240 - Relational Databases and Information Systems. The site was built using PHP using material from COMP30680 - Web Application Development, also offered by UCD. Additional references have been included in the PHP files.

## Design Description
When the user enters the site, they are greeted with a page that displays all interviews that the company have a record of. These interviews may have not yet taken place. The interview table gives the interview IDs, which uniquely identify the interviews in the table, along with candidate IDs, department IDs, position IDs, interview dates and results (either accepted or rejected, or blank in the case where either the interview has not taken place or the decision has not yet been made). The user can click on elements in the Candidate ID, Department ID, and Position ID columns to gain more detailed information.

### Candidate Page
When the user clicks on a candidate ID in the interview table, they are redirected to a separate page (candidate.php). Here, they are shown more detailed information about the candidate with the corresponding candidate ID, including their full name, phone number, and address. They are also presented with a candidate skills table, which shows all the skills that the candidate has listed on their job application. 

### Department Page
When the user clicks on a department ID in the interview table, they are redirected to a separate page (department.php). Here, they are shown information pertaining to the department with the associated department ID, including the department name, branch name, branch address, and branch phone number.

### Position Page
When the user clicks on a position ID in the interview table, they are redirected to a separate page (position.php). Here, they are shown information pertaining to the position with being offered by the company with the associated position ID, including the ID of the department offering the position, the position type, the associated salary, and a brief description of the position. The department ID column also includes links to the Department Page described above. The user is also presented with a position skills table, which shows all the skills required by the position, as outlined on the job description posted by the company. 