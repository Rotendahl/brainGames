<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <title>Huskespil</title>


    <style type="text/css">
        body {
            margin: 0;
            padding: 0;
            background-color: #E0E0E0;
            color: #000;
            font-size: 12px;
            font-family: Arial, Helvetica;
        }

        .medium {
            font-size: 15px;
            font-weight: bold;
        }

        .big {
            font-size: 24px;
            font-weight: bold;
        }

        .rel {
            position: relative;
        }

        .overlay {
            position: absolute;
            width: 50%;
            height: 80%;
            margin: 10% 25%;
            background-color: #5FACDA;
            border: solid 10px;
            border-color: #FAF114;
            text-align: left;
            font-size: 40px;
        }

        canvas {
            margin: 0;
            padding: 0;
        }

        canvas.small {
            width: 300px;
            height: 300px;
        }

        canvas.wide {
            width: 100%;
            height: 300px;
        }

        .col {
            margin-bottom: 50px;
        }
    </style>

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
            $username = "rotendah_hjerne";
            $qry = "SELECT * FROM huske ORDER BY score DESC;";


            // Create connection
            $con = mysql_connect($servername, $username, $password);
            $db  = mysql_select_db("rotendah_hjerne", $con);
            $res = mysql_query($qry);

            $nrRows = 1;
            while($row = mysql_fetch_assoc($res) and $nrRows <= 10) {
                $htmlCode = $htmlCode . $nrRows . " : " . $row["perName"] . " : " . $row["score"] . "<br>";
                $nrRows++;
            }

            $htmlCode = $htmlCode . "</center>";
            ehco $htmlCode
          ?>
    </div>
</body>

</html>
