<!DOCTYPE html>
<html>
    <head>
        <meta name = "author" content = "Луцай Катерина, ІТ-91">
        <link rel="stylesheet" href="css/style.css">
        <title>Church of Delomemat</title>
    </head>
<body>
<div class="all">
    
    <div class="feedback">

        <h2>Feedback:</h2>
        <form method="POST" action="" id="feedback-form">
            <p>You:</p>
            <input type="text" name="name" required placeholder="anon">
            <p>Email:</p>
            <input type="email" name="email" required placeholder="emai@example.com">
            <p>Message:</p>
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