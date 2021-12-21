<?php
    // Initialize the session
    session_start();
    
    // Check if the user is logged in, if not then redirect him to login page
    if(!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true){
        header("location: login.php");
        exit;
    }
    
    // Initialise Result Array with all results included
    $results = Array("Accepted", "Rejected", "Pending");

    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        // Remove a result from the array if it has not been selected by the user
        if (empty($_POST["Accepted"])) {
            $results = array_diff($results, array("Accepted"));
        } 

        if (empty($_POST["Rejected"])) {
            $results = array_diff($results, array("Rejected"));
        } 

        if (empty($_POST["Pending"])) {
            $results = array_diff($results, array("Pending"));
        } 
    }

    // Convert results array to a string for the SQL query
    $results = implode("','", $results);
?>

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
    <link href="//cdn.datatables.net/1.11.3/css/jquery.dataTables.min.css" rel="stylesheet">
    <title>Salescorp Interviews</title>
</head>
<body class="d-flex flex-column min-vh-100">
    <!-- Navbar - Reference: https://github.com/academind/bootstrap4-introduction/blob/03-navbar/index.html -->
    <?php
        require_once "Navbar.php";
    ?>

    <h1>Interviews</h1>

    <form class="border" method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">
        <div class="form-check form-check-inline">
            <input type="checkbox" class="form-check-input" name="Accepted" value="Accepted" <?php if (isset($_POST["Accepted"])) echo "checked";?>></input>
            <label for="Accepted" class="form-check-label">
                Accepted
            </label>
        </div>
        <div class="form-check form-check-inline">
            <input type="checkbox" class="form-check-input" name="Rejected" value="Rejected" <?php if (isset($_POST["Rejected"])) echo "checked";?>></input>
            <label for="Rejected" class="form-check-label">
                Rejected
            </label>
        </div>
        <div class="form-check form-check-inline">
            <input type="checkbox" class="form-check-input" name="Pending" value="Pending" <?php if (isset($_POST["Pending"])) echo "checked";?>></input>
            <label for="Pending" class="form-check-label">
                Pending
            </label>
        </div>
        <button type="submit" class="btn btn-secondary my-2" name="submit" value="Get Interviews">Get Interviews</button>
    </form>

    <div class="table-responsive m-2">
        <!-- Table - Reference: https://getbootstrap.com/docs/4.0/content/tables/ -->
        <table id="interview-table" class="table table-striped table-sortable">
            <thead>
                <tr>
                    <th scope="col" style="cursor: pointer;">Interview ID<i class="fas fa-sort"></i></th>
                    <th scope="col" style="cursor: pointer;">Candidate ID<i class="fas fa-sort"></i></th>
                    <th scope="col" style="cursor: pointer;">Department ID<i class="fas fa-sort"></i></th>
                    <th scope="col" style="cursor: pointer;">Position ID<i class="fas fa-sort"></i></th>
                    <th scope="col" style="cursor: pointer;">Date<i class="fas fa-sort"></i></th>
                    <th scope="col" style="cursor: pointer;">Result<i class="fas fa-sort"></i></th>
                </tr>
            </thead>
            
            <tbody>
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
                            $stmt = $conn->prepare("SELECT * FROM interview WHERE result in ('" . $results . "')");
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
            </tbody>
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
    <script src="jquery-3.6.0.js"></script>
    <script src="//cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#interview-table').DataTable( {
                searching: false,
                ordering: false,
                responsive: true,
                "pageLength": 10
            } );
        } );
    </script>
</body>
</html>