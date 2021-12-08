<?php 
session_start();
include "../php/db.php";
include "../php/login.php";
include "../php/lang.php";
include "../php/wishes.php";
$conn = OpenCon();
?>

<!DOCTYPE html>
<html>
    <head>
        <meta name = "author" content = "Луцай Катерина, ІТ-91">
        <link rel="stylesheet" href="../css/style.css">
        <script type="text/javascript" src="../json/texts.json"></script>
        <script type="text/javascript" src="../json/wishes.json"></script>
        <style>
            a:link {color: #AEAD3A;}
            a:visited {color: #F3B71A;}
            a:hover {color: #FDF399;}
            a:active {color: #FDF399;}
        </style>

        <link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
        <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
        <script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="../js/script.js"></script>
        <title>Church of Delomemat</title>
    </head>
<body onload="load();">

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

    <div class="content"> 

    <header>
        <div class="langs right">
        <?php LangSwitch($conn); ?> 
            <a href="index.php?lang=EN"> <img src="../images/flag_en.png"> </a>
            <a href="index.php?lang=RU"> <img src="../images/flag_ru.png"> </a>
            <a href="index.php?lang=UA"> <img src="../images/flag_ua.png"> </a>
        </div>
        <h1 id="headTitle">Church of Delomemat</h1>
        <h2 id="subTitle"><b>Delomemat</b> (from Greek: <b>delo</b> - <i>Visible</i>, <b>memat</b> - <i>Desired</i>) <b>Деломем</b> – бог всех мемоделов.</h2>
        <?php LoginForm($conn); ?>
    </header>

    <div class="main"> 
        <img id="look" data-palette="white" src="../images/bw.png" alt="image of delomemat" target="_blank">
        <div id="social">        
            <a href="https://t.me/brokenbloomer" class="fa fa-telegram" target="_blank"></a>
            <a href="https://www.instagram.com/brokenbloomer/" class="fa fa-instagram" target="_blank"></a>
            <a href="https://github.com/K4TEL" class="fa fa-github" target="_blank"></a>
            <a href="https://vk.com/kate_lutsai" class="fa fa-vk" target="_blank"></a>
        </div>
    </div>

    <div class="pray">
        <h2>Donate:</h2>
        <div id="slider">
            <div id="custom-handle" class="ui-slider-handle"></div>
        </div>
        <h2>Pray:</h2>
        <form method="POST" action="" id="pray-form" >
            <input name="wishText" id="wish" type="text" placeholder="type your wish here...">
            <input name="wishSubmit" type="submit" value="Pray!" onclick="writeWish()">
        </form>
        <?php Wish($conn);?>
        <p id="donated">Donated: $<span class="countfect" data-num="<?php Fund($conn); ?>"></span></p>

        <ul id="prays">
            <?php SelectWishes($conn); ?>
        </ul>
    </div>    
    </div>
</div>
<script>
    if (!sessionStorage.getItem("age")) {
        isAdult();
    }

    function isAdult() {
        age = prompt("How old are you?", 18);
    
        if (age < 18) {
            let isResp = confirm("Confirm your full responsibility on using this application");
            if (!isResp) {
                alert("You are not allowed to use this application");
                close();
            } 
        }

        sessionStorage.setItem("age", age);
    }
</script>
<?php CloseCon($conn); ?>
</body>
</html>