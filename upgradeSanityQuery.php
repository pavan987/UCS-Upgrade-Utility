<?php
error_reporting(E_ERROR | E_WARNING | E_PARSE);
ini_set('display_errors', 1);
set_include_path(get_include_path() . PATH_SEPARATOR . 'phpseclib');
$Branch=$_POST['Branch'];
$Build=$_POST['Build'];
$Type=$_POST['Type'];
$platform=$_POST['platform'];

include('Net/SSH2.php');

$ssh = new Net_SSH2('10.197.123.48');
if (!$ssh->login('root', 'Nbv54321')) {
    exit('Login Failed');
}


$build= $ssh->exec("./getSanity.pl $Branch $Build $Type $platform");
if(preg_match("/PASS/",$build))
{$color="green";}
elseif(preg_match("/FAIL/",$build))
{$color="red";}
else
{$color="blue";}

echo "<span style='color:$color'> $build </span> ";

?>
