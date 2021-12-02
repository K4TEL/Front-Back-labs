<?php 
session_start();
include "../php/db.php";
include "../php/lang.php";
$conn = OpenCon();
LangSwitch($conn);
CloseCon($conn);
?>

<!DOCTYPE html>
<html>
    <head>
        <meta name = "author" content = "Луцай Катерина, ІТ-91">
        <link rel="stylesheet" href="../css/style.css">
        <style>
            a:link {color: #AEAD3A;}
            a:visited {color: #F3B71A;}
            a:hover {color: #FDF399;}
            a:active {color: #FDF399;}
        </style>
        <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
        <script src="../js/script.js"></script>
        <title>Contact</title>
    </head>
<body onload="nav();">
<div class="all">
<div class="nav">
        <a data-action="main" id="mainlink">Main page</a>
        <br>
        <a data-action="origins">Origins</a>
        <br>
        <a data-action="cult">Cult</a>
        <br>
        <a data-action="symbol">Symbolics</a>
        <br>
        <a data-action="contact">Contact</a>
    </div>

    <div class="content feedback">

        <h2 id="headTitle">Feedback:</h2>
        <form method="POST" action="" id="feedback-form">
            <p id="youLabel">You:</p>
            <input type="text" name="name" required placeholder="anon">
            <p id="emailLabel">Email:</p>
            <input type="email" name="email" required placeholder="emai@example.com">
            <p id="messageLabel">Message:</p>
            <textarea name="message" required rows="5" placeholder="Hello, admin..."></textarea>
            <input type="submit" name="submit" value="Send">
        </form>

        <?php
if (isset($_POST['submit'])) {
    $name = $_POST['name'];
    $email = $_POST['email'];
    $message = $_POST['message'];

    $from = 'From: Church of Delomemeat';
    $to = 'lutsai.k@gmail.com';
    $subject = 'Feedback';
    $body = "From: $name\nE-Mail: $email\nMessage:\n$message";

    $success = mail($to, $subject, $body, $from);
    
    if (!$success) {
        $errorMessage = error_get_last()['message'];
        echo `<p>` . $errorMessage . `</p>`;
    } else {
        echo '<p>Your message has been sent! '. date("Y.m.d") . '</p>';
    }
}
?>
    
    </div>
</div>
</body>
</html>