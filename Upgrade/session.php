<?php
error_reporting(E_ERROR | E_WARNING | E_PARSE);
ini_set('display_errors', 1);
session_start();
if(!isset($_SESSION['email']))
{
header("location: /");
}
else
{
include ($_SERVER['DOCUMENT_ROOT'].'/connection.php');
$email=$_SESSION['email'];
}
?>
