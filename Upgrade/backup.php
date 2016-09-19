<?php
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

<!DOCTYPE html>
<html>
<head>

<title>
Upgrade Infra of UCSM
</title>

<!-- Meta Tags -->
<meta charset="utf-8">
<meta name="generator" content="Wufoo">
<meta name="robots" content="index, follow">

<!-- CSS -->
<link href="css/structure.css" rel="stylesheet">
<link href="css/form.css" rel="stylesheet">

<!-- JavaScript -->
<script src="js/wufoo.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"> </script>
<script>

$(document).ready(function(){
$("#found").change(function() {
var value=$("#found").val();
$("#activity").load("list-query.php",{column:value});
});
});
</script>

<!--[if lt IE 10]>
<script src="https://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
</head>

<body id="public">
<div id="container" class="ltr">

<form id="form1" name="form1" class="wufoo leftLabel page" accept-charset="UTF-8" autocomplete="off" enctype="multipart/form-data" method="post" novalidate
      action="#">
  
<header id="header" class="info">
<h2>Upgrade Infra Structure Bundle of UCSM</h2>
<div style="color:red">This will upgrade infra of registered testbed using autoinstall </div>
</header>
<p class="congrats"></p>
<ul>

<li id="foli17" class="notranslate       ">
<label class="desc" id="title17" for="Field17">
Branch
<span id="req_17" class="req">*</span>
</label>
<div>
<select id="found" name="found" class="field select medium" tabindex="10" > 
<option value="" selected="selected" >
Select
</option>
<option value="nj_dev-builds" selected="selected">
New_Jersey
</option>
<option value="elcapitan-builds" >
Elcapitan
</option>
<option value="fletcher_cove-builds" >
Fletcher_Cove
</option>
</select>
</div>
</li> 

<li id="foli19" class="notranslate       ">
<label class="desc" id="title19" for="Field19">
Build
<span id="req_19" class="req">*</span>
</label>
<div>
<select id="activity" name="activity" class="field select medium" tabindex="1" > 
</select>
</div>
</li>

<li class="buttons ">
<div>

<input id="saveForm" name="saveForm" class="btTxt submit" type="submit" value="Submit" /></div>
</li>

</ul>

</form> 

</div><!--container-->

</body>
</html>

