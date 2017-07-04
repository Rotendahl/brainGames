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
        //   rotendahl.dk/postScore.php?game=react&name=benja&score=10

        $game = $_GET["game"];
        $name = $_GET["name"];
        $score = $_GET["score"];

        $servername = "rotendahl.dk";
        $username = "rotendah_brain";
        $password = "xJjdXizs}23B7V[EGMZutmv[sU2";
        //INSERT INTO react (perName, score) VALUES ('benj', 314)
        $qry = "INSERT INTO " . $game . " (perName, score) VALUES ( '" . $name . "', " .$score . ")";

        //echo $qry;
        // Create connection
        $con = mysql_connect($servername, $username, $password);
        $db  = mysql_select_db("rotendah_brain", $con);
        $res = mysql_query($qry);

        ?>
    </p>

    <canvas id="demo" data-processing-sources="score.pde">
    </canvas>
</body>

</html>
