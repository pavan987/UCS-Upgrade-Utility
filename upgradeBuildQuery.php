<?php
error_reporting(E_ERROR | E_WARNING | E_PARSE);
ini_set('display_errors', 1);
set_include_path(get_include_path() . PATH_SEPARATOR . 'phpseclib');
$Branch=$_POST['Branch'];

include('Net/SSH2.php');

$ssh = new Net_SSH2('10.197.123.48');
if (!$ssh->login('root', 'Nbv54321')) {
    exit('Login Failed');
}


#$build= $ssh->exec("./getBuildsList.pl $Branch");
$build= $ssh->exec("./getBuildsList.pl $Branch");
$builds = explode("\n", $build);
foreach ($builds as $val) {
echo "<option>" . $val . "</option>";
}

?>
