<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="../css/frame.css"> 
        <meta name = "author" content = "Луцай">
        <title>7 Лабораторна робота</title>
    </head>
<body>
    <?php 
    function OpenCon() {
    $dbhost = "localhost";
    $dbuser = "admin";
    $dbpass = "admin";
    $db = "trainschedule";
   
    $conn = new mysqli($dbhost, $dbuser, $dbpass,$db) or die("Connect failed: %s\n". $conn -> error);
    return $conn;
    }
    
   function CloseCon($conn) {
    $conn -> close();
    }

    function sql_to_html_table($sqlresult, $delim="\n") {
        // starting table
        $htmltable =  "<table>" . $delim ;   
        $counter   = 0 ;
        // putting in lines
        while( $row = $sqlresult->fetch_assoc()  ){
          if ( $counter===0 ) {
            // table header
            $htmltable .=   "<tr>"  . $delim;
            foreach ($row as $key => $value ) {
                $htmltable .=   "<th>" . $key . "</th>"  . $delim ;
            }
            $htmltable .=   "</tr>"  . $delim ; 
            $counter = 22;
          } 
            // table body
            $htmltable .=   "<tr>"  . $delim ;
            foreach ($row as $key => $value ) {
                $htmltable .=   "<td>" . $value . "</td>"  . $delim ;
            }
            $htmltable .=   "</tr>"   . $delim ;
        }
        // closing table
        $htmltable .=   "</table>"   . $delim ; 
        // return
        return( $htmltable ) ; 
      }
      
   $conn = OpenCon();
   ?>


<h2>Make a record:</h2>
        <form method="POST" action="" id="trainSchedule">
        <div class="left">

            <p>Station:</p>
            <select name="station" required>
            <?php 
            $result = $conn->query("SELECT id, title FROM stations");
            while ($row = $result->fetch_assoc()){
                echo "<option value=" . $row['id'] . ">" . $row['title'] . "</option>";
            }
            ?>
            </select>

            <p>Race:</p>
            <select name="race" required>
            <?php 
            $result = $conn->query("SELECT id, title FROM races");
            while ($row = $result->fetch_assoc()){
                echo "<option value=" . $row['id'] . ">" . $row['title'] . "</option>";
            }
            ?>
            </select>

            <p>Arrival:</p>
            <input name="arrivalDate" type="date" required>
            <input type="time" name="arrivalTime" required>

        </div>
        <div class="right">

            <p>Rail:</p>
            <input type="number" name="rail" required placeholder="1">
            
            <p>Train:</p>
            <input type="number" name="train" required placeholder="1001">
            
            <p>Departure:</p>
            <input name="departureDate" type="date" required>
            <input type="time" name="departureTime" required>

        </div>
        <input type="submit" name="submitRecord" value="Record">
        </form>
        <div class="trainshed">
        <form method="POST" action="" id="trainSearch">
            <input type="text" name="search" placeholder="Searching for...">
            <input type="submit" name="submitSearch" value="Search">
        </form>
            <?php
            if (isset($_POST['submitRecord'])) {
                $rail = $_POST['rail'];
                $train = $_POST['train'];
                $station = $_POST['station'];
                $race = $_POST['race'];
                $arrival = $_POST['arrivalDate'] . " " . $_POST['arrivalTime'];
                $departure = $_POST['departureDate'] . " " . $_POST['departureTime'];
            
                $sql = "INSERT IGNORE INTO schedule (id, arrival, departure) 
                VALUES (NULL, '".$arrival."', '".$departure."')";
                
                if ($conn->query($sql) === FALSE) 
                    echo "Error: " . $sql . "<br>" . $conn->error;
            
                $id = mysqli_insert_id($conn);
            
                $sql = "UPDATE schedule s, rails r
                SET s.idLocation = r.id 
                WHERE r.idStation = ".$station." AND r.number = ".$rail." AND 
                s.id=".$id.";";
            
                if ($conn->query($sql) === FALSE) 
                    echo "Error: " . $sql . "<br>" . $conn->error;
            
                $sql = "UPDATE schedule s, trainsonrace t
                SET s.idTransport = t.id 
                WHERE t.idRace = ".$race." AND t.numTrain = ".$train." AND 
                s.id=".$id.";";
            
                if ($conn->query($sql) === FALSE) 
                    echo "Error: " . $sql . "<br>" . $conn->error;

                    $sql = "SELECT stations.title AS 'Station', 
                    rails.number AS 'Rail number',
                    trains.number AS 'Train',
                    schedule.arrival AS 'Arrival time', 
                    schedule.departure AS 'Departure time', 
                    races.title AS 'Race'
                    FROM schedule, trainsonrace, stations, trains, rails, races
                    WHERE rails.id = schedule.idLocation 
                    AND stations.id = rails.idStation
                    AND trainsonrace.id = schedule.idTransport
                    AND races.id = trainsonrace.idRace
                    AND trains.number = trainsonrace.numTrain";
        
                    $result = $conn->query($sql);
                    echo sql_to_html_table( $result, $delim="\n" ); 
                
            }

            if (isset($_POST['submitSearch'])) {
                $search = $_POST['search'];
                $sql = "SELECT stations.title AS 'Station', 
            rails.number AS 'Rail number',
            trains.number AS 'Train',
            schedule.arrival AS 'Arrival time', 
            schedule.departure AS 'Departure time', 
            races.title AS 'Race'
            FROM schedule, trainsonrace, stations, trains, rails, races
            WHERE rails.id = schedule.idLocation 
            AND stations.id = rails.idStation
            AND trainsonrace.id = schedule.idTransport
            AND races.id = trainsonrace.idRace
            AND trains.number = trainsonrace.numTrain 
            AND concat(stations.title,
                rails.number,
                trains.number,
                schedule.arrival,
                schedule.departure,
                races.title) LIKE '%".$search."%'" ;

            $result = $conn->query($sql);
            echo sql_to_html_table( $result, $delim="\n" ); 
            }
        
            CloseCon($conn);
            ?>
        </div>
</body>
</html>