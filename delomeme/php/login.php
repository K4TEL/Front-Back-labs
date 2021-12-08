<?php 
    function LoginForm($conn) {
        ?>
        <form method="POST" action="" id="login-form">
            <div class="login-form"> <?php
        if (!isset($_SESSION['user'])) { ?>
                <input name="login" type="text" required>
        <?php } else { ?>
            <input name="login" type="text" value="<?php echo $_SESSION['user'];?>" required>
        <?php } ?>
                <input name="password" type="password" required>
                <input type="submit" name="loginSubmit" value="Login">
            </div>
        </form>
        <?php
        if (isset($_POST['loginSubmit'])) {
            if (Login($conn, $_POST['login'], $_POST['password'])) {
                $_SESSION['user'] = $_POST['login'];
                header("Refresh:0;");
            } else {
                echo "<p><span class='error'>Wrong password</span></p>";
            }
        }
    }

    function Login($conn, $login, $pass) {
        $sql = "SELECT password FROM users WHERE login='$login'";
        $result = $conn->query($sql);
        if (mysqli_num_rows($result) === 1) {
            $row = $result->fetch_assoc();
            if ($row['password'] === $pass) {
                return true;
            } else {
                session_destroy();
                session_unset();
                $_SESSION = array();
                return false;
            }
        } else {
            $sql = "INSERT IGNORE INTO users (login, password) 
            VALUES ('".$login."', '".$pass."')";
            if ($conn->query($sql) === FALSE) 
                echo "Error: " . $sql . "<br>" . $conn->error;
            return true;
        }
    }
?>