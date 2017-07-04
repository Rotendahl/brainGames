<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <title>Huskespil</title>


    <link rel="stylesheet" type="text/css" href="../assets/style.css">
    <script type="text/javascript" src="../assets/jprocessingjs-0.9.min.js"></script>
    <script type="text/javascript" src="../assets/processing-1.4.1.min.js"></script>
</head>

<body>
    <p>
        <?php
        ?>
    </p>

    <canvas id="demo" data-processing-sources="viewScore.pde">
      </canvas>
    <div class="overlay">
        <?php
            $htmlCode = "<center><h1>Highscores</h1><br>";

            $servername = "rotendahl.dk";
            $username = "rotendah_brain";
            $qry = "SELECT * FROM reaktion ORDER BY score DESC;";


            // Create connection
            $con = mysql_connect($servername, $username, $password);
            $db  = mysql_select_db("rotendah_brain", $con);
            $res = mysql_query($qry);

            $nrRows = 1;
            while($row = mysql_fetch_assoc($res) and $nrRows <= 10) {
                $htmlCode = $htmlCode . $nrRows . " : " . $row["perName"] . " : " . $row["score"] . "<br>";
                $nrRows++;
            }

            echo $htmlCode . "</center>";
          ?>
    </div>
</body>

</html>
