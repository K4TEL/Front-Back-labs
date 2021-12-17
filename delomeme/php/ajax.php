<?php 

session_start();
include "../php/db.php";
$conn = OpenCon();

if(!isset($_SESSION["user"])) {
    echo "<p><span class='error'>Login first!</span></p>";
} else {

    if(isset($_POST["text"])) {
    $sum =  $_POST["sum"];
    $text = $_POST["text"];
    $user = $_SESSION["user"];

    $sql = "CALL Wish('$user','$text','$sum')";
    $result = $conn->query($sql);
    if ($result === FALSE) 
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
}

CloseCon($conn);
?>