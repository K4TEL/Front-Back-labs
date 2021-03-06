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
        <title>Cult and Patronages</title>
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
<h1 id="headTitle">Cult and Patronages</h1>

<a href="../images/memedad.png" target="_blank">
<img src="../images/memedad.png" alt="typical memedel" target="_blank">
</a>

<div id="infoLeft" class="left">
<p><span>Мемодел</span> – служитель Деломема, который занимается производством, воровством и распространением единиц «значимой» для культуры информации.</p>
<p>Чаще всего встречаются в социальных сетях, где проявляются как администраторы/редакторы каналов и комментаторы записей. </p>
<p>Деятельность мемоделов сводится к хобби, но нередко перерастает и в полноценную профессию. Так называемых СММщиков принято обоссывать при встрече за «продажность» и служение ложному капиталистическому божеству. </p>

<h2>Tools</h2>

    <p>По заветам Деломема, чем больше оригинальных мемов производит его служитель, тем больше profit. Для этого принято использовать любой графический редактор.</p>
    <p>Однако, воровство и репост чужих творений тоже поощряется.</p>
    <p>Любой мемодел не обходится и без собственного хранилища «сохранёнок», размером и древностью которого измеряется статус в иерархии служителей Деломема. </p>
</div>

<div id="planRight" class="right">
<h2>Daily ПЛАН</h2>

<ul>
    <li>Помолиться Деломему</li>
    <li>Найти канал чтоб пиздить оттуда мемы:</li>
        <ol>
            <li>Спиздить мем</li>
            <li>Сохранить канал</li>
        </ol>
    <li>Запостить:</li>
        <dl>
            <dt>Original content</dt>
                <dd>Творчество, обзоры, уникальная информация, собственные мемы и т.д.</dd>
            <dt>Shitposting</dt>
                <dd>Ворованые мемы, ссылки на ютуб</dd>
            <dt>Cringe</dt>
                <dd>Постыдные мемы (проверить не отписался ли кто-то после)</dd>
            </dl>
    <li><i>Накормить собой толпу</i></li>
</ul>
</div>
</div>
</div>
<?php CloseCon($conn); ?>
</body>
</html>