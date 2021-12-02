<?php 

function LangSwitch($conn) {
    $langs = array('EN', 'RU', 'UA');
    if(!isset($_COOKIE["lang"])) {
        setcookie("lang", "EN", time() + (86400 * 30 * 6), "/");
    }

    if (isset($_GET['lang']) && in_array($_GET['lang'], $langs)) {
        setcookie("lang", $_GET['lang']);
        $_COOKIE["lang"] = $_GET['lang'];
    }

    if (isset($_COOKIE['lang'])) {
        $chosen = "";
        $lang = $_COOKIE['lang'];
        switch ($lang) {
            case "EN":
                $chosen = "English language is chosen";
                break;
            case "RU":
                $chosen = "Выбран русский язык";
                break;
            case "UA":
                $chosen = "Обрана Українська мова";
                break;
        }
        echo "<p>$chosen</p>";

        $url = $_SERVER['REQUEST_URI'];
        preg_match('/(\w+)(?!.*(\w+)(\.\w+)+)/', $url, $page);
        
        $sql = "CALL SelectPageTexts('$page[0]','$lang')";
        $result = $conn->query($sql);
        $fp = fopen('../json/texts.json', 'w');
        $emparray = array();
        while($row = mysqli_fetch_assoc($result)) {
            $emparray[] = $row;
        }
        fwrite($fp, json_encode($emparray));
        fclose($fp);
        while(mysqli_more_results($conn)) {
            mysqli_next_result($conn);
        }
    }
}
?>