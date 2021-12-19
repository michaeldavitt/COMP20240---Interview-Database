<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link rel="stylesheet" href="styles.php">
    <!-- FontAwesome -->
    <link 
        rel="stylesheet"
        href="https://use.fontawesome.com/releases/v5.3.1/css/all.css"
        integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
    <title>Salescorp Interviews</title>
</head>
<body class="d-flex flex-column min-vh-100">
    <!-- Navbar - Reference: https://github.com/academind/bootstrap4-introduction/blob/03-navbar/index.html -->
    <?php
        require_once "Navbar.php";
    ?>

    <h1>Interviews</h1>

    <div class="table-responsive">
        <!-- Table - Reference: https://getbootstrap.com/docs/4.0/content/tables/ -->
        <table id="interview-table" class="table table-striped">
            <tr>
                <th scope="col">Interview ID</th>
                <th scope="col">Candidate ID</th>
                <th scope="col">Department ID</th>
                <th scope="col">Position ID</th>
                <th scope="col">Date</th>
                <th scope="col">Result</th>
            </tr>

            <?php
                // Define a class for creating the tables
                require_once "TableRows.php";

                // Read in the specifications for connecting to the database
                require_once "dbconfig.php";

                // Connect to the database
                try {
                    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
                    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

                    try {
                        $stmt = $conn->prepare("SELECT * FROM interview");
                        $stmt->execute();

                        // set the resulting array to associative
                        $result = $stmt->setFetchMode(PDO::FETCH_ASSOC);
                            
                        foreach(new TableRows(new RecursiveArrayIterator($stmt->fetchAll())) as $k=>$v) {
                            echo $v;
                        }

                    }

                    catch(PDOException) {
                        echo "<p class=\"error-message\">Error: Data unavailable. Failed to extract data pertaining to interviews. Please try again later</p>";
                    }

                } 
                
                // Exception handling for when we can't connect to the database or if the query fails
                catch(PDOException) {
                    echo "<p class=\"error-message\">Error: Data unavailable. Failed to connect to database. Please try again later</p>";
                }
                
                // Remove connection to the database when we have all the required data.
                $conn = null;
            ?>

        </table>
    </div>
    
    
    <!-- Footer - Reference: https://mdbootstrap.com/docs/standard/navigation/footer/ -->
    <?php
        require_once "Footer.php";
    ?>

    <!-- JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <script src="main.js"></script>
    <script>convert_to_buttons("interview-table", [1,2,3], ["candidate.php", "department.php", "position.php"])</script>
</body>
</html>