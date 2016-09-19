<?php
include ($_SERVER['DOCUMENT_ROOT'].'/configure/ssh.php');
session_start();
if(isset($_POST['branch']) && isset($_POST['build']) && isset($_SESSION['email']))
{
$email=$_SESSION['email'];
$branch=$_POST['branch'];
$build=$_POST['build'];
$type=$_POST['type'];
$Image=$_POST['Image'];
$platform=$_POST['platform'];
$stream = ssh2_exec($connection,"/usr/bin/perl /var/www/html/perl/".$Image."Upgrade.pl $email $branch $build $type $platform");
echo "Success";
}
else
{ echo "Please select the Required fields";
 }


?>

