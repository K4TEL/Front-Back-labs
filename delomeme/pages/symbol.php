<?php 
session_start();
include "../php/db.php";
include "../php/lang.php";
$conn = OpenCon();
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
        <title>Symbolics</title>
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
    
        <div class="main"> 
            <header>
            <?php LangSwitch($conn); ?>
        </header>
<h1 id="headTitle">Epithets and Attributes</h1>
<h2 id="subTitle">If you notice man with horn and wand, wearing herbal wreath on his head, maybe it’s Delomemat himself, but maybe you should stop doing drugs.</h2>

<table>
    <colgroup>
        <col bgcolor="#104200"/><col/><col/>
    </colgroup>
    <caption id="caption">Традиционные атрибуты Деломема</caption>
        <thead>
    <tr id="header">
        <th>Image</th>
        <th>Title</th>
        <th>Description</th>
    </tr>
        </thead>
        <tbody>
    <tr>
        <td><a href="../images/horn.png" target="_blank">
            <img src="../images/horn.png" target="_blank">
            </a>
        </td>
        <td><a href="javascript:goWiki('https://en.wikipedia.org/wiki/Horn_(instrument)')">Horn</a></td>
        <td id="descrHorn">
            <p>Атрибут глашатаев, который в наше время существует в виде share/repost кнопок. </p>
            <p>Герольды трубили в рог при любом удобном случае в честь торжества, начала или окончания войны и т. д.</p>
            <p>Символизирует распространение информации.</p>
        </td>
    </tr>
    <tr>
        <td><a href="../images/zveroboy.png" target="_blank">
            <img src="../images/zveroboy.png" target="_blank">
            </a>
        </td>
        <td><a href="javascript:goWiki('https://en.wikipedia.org/wiki/Wreath')">Wreath</a></td>
        <td id="descrWreath">
            <p>Венок из любимых трав Деломема это его постоянный головной убор. Именно из-за букета зверобоя и конопли Деломем всегда позитивно настроен и смотрит на мир с улыбкой.</p>
            <p>Такое же отношение к миру проповедует он и для мемоделов, призывая их ко всему относиться менее серьезно («на похуй»).</p>
        </td>
    </tr>
    <tr>
        <td><a href="../images/wand.png" target="_blank">
            <img src="../images/wand.png" target="_blank">
            </a>
        </td>
        <td><a href="javascript:goWiki('https://en.wikipedia.org/wiki/Wand')">Wand</a></td>
        <td id="descrWand">
            <p>Палка –копалка, которая делает из ничего что-то.</p>
            <p>Жезл это один из главных атрибутов Деломема, которым он указывает направление мысли мемоделам.</p>
            <p>Как фаллический символ подразумевает распространение мемов-генов.</p>
        </td>
    </tr>
        </tbody>
        <tfoot>
    <tr>
        <td id="x" rowspan="2">X</td>
        <td colspan="2"  id="descrPlanet">
            <p>Какого-то единого символа это божество не имеет, так как все ближайшие планеты разобрали более могущественные небожители.</p>
        </td>
    </tr>
    <tr>
        <td colspan="2"  id="descrHumor">
            <p>Иногда сюда же причисляют сборник анекдотов, или любой другой источник юморесок, но этот инструмент можно скорее отнести к атрибутам самих мемоделов.</p>
        </td>
    </tr>
        </tfoot>
</table>
</div>
</div>
<?php CloseCon($conn); ?>
</body>
</html>