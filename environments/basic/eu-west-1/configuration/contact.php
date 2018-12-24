<!DOCTYPE html>
<html>
<body>

<h1>Contact Page</h1>
<?php
echo "<h1>Instance data</h1>";
$xml = file_get_contents("http://169.254.169.254/latest/meta-data/public-ipv4");
var_dump($xml);
?>

</body>
</html>

