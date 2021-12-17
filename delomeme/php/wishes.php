<?php 

function SelectWishes($conn) {
    $sql = "CALL SelectWishes()";
    $result = $conn->query($sql);
    if ($result === FALSE) 
                echo "Error: " . $sql . "<br>" . $conn->error;

    while( $row = $result->fetch_assoc()  ){
        if ($row["isDonated"]) {
          echo '<li class="accordion-item">
            <div class="accordion-header">
              <p>'.$row["text"].'<span>$'.$row["sum"].'</span></p>
              </div>
              <div><p>'.$row["date"].'</p>
              <p>by '.$row["login"].'</p>
              </div>
            </li>';
        } else {
            echo '<li class="accordion-item">
            <div class="accordion-header">
              <p>'.$row["text"].'</p>
              </div>
              <div><p>'.$row["date"].'</p>
              <p>by '.$row["login"].'</p>
              </div>
            </li>';
            }
        }
    while(mysqli_more_results($conn)) {
        mysqli_next_result($conn);}
}
function Fund($conn) {
    $sql = "CALL DonationSum()";
    $result = $conn->query($sql);
    if ($result === FALSE) {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
    $row = $result->fetch_assoc();
    echo $row["fund"]; 
    while(mysqli_more_results($conn)) {
        mysqli_next_result($conn);}
}

function Wish($conn) {
    if (isset($_POST['wishSubmit'])) {
        if(!isset($_SESSION["user"])) {
            echo "<p><span class='error'>Login first!</span></p>";
        } else {

        $sum =  $_COOKIE["donation"];
        $text = $_POST["wishText"];
        $user = $_SESSION["user"];

        // $sql = "CALL Wish('$user','$text','$sum')";
        // $result = $conn->query($sql);
        // if ($result === FALSE) 
        //     echo "Error: " . $sql . "<br>" . $conn->error;
        }
    }
}
?>