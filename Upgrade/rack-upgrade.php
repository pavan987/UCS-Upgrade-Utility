<?php
include 'session.php';
?>

<div class="content">
<h1> Upgrade C-series Firmware </h1>
<h2>( This upgrades C-series Server endpoints of registered testbed using Host Firmware Pack )</h2>
<form action="#" method="POST" id="upgrade">

<h2> Branch </h2>
<select name="branch" id="branch">
<option value="" selected="selected" >
Select
</option>
<option value="granada-builds" >
Granada
</option>
</select>

<br><br>

<h2> Build 
<span id="buildanim" style="visibility: hidden" ><img src="images/buildanim.gif" /><!-- Place at bottom of page --></span> </h2>
<select name="build" id="build">
</select>
<br><br>


<h2> Type </h2>
<select name="type" id="type">
<option value="gbin" selected="selected" >
gdb
</option>
<option value="bin">
final
</option>

</select>
<br><br>
<h2>Build Status
<span id="statusanim" style="visibility: hidden" ><img src="images/statusanim.gif" /><!-- Place at bottom of page --></span> </h2>
<input type="button" value=" Check " id="check" /> <span id="status"></span>
<br><br><br>
<input type="submit" value=" Upgrade " id="button" /> 
</form>
</div>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"> </script>
<script>


$("#branch").change(function() {
$("#buildanim").css('visibility', 'visible');
var branch=$("#branch").val();
$("#build").load("upgradeBuildQuery.php",{Branch:branch},function() {
$("#buildanim").css('visibility', 'hidden');
});

});

$("#upgrade").on("submit",function(event){
event.preventDefault();
$.post("/Upgrade/upgrade-action.php",$("#upgrade").serialize()+'&Image=c', function(data) {
if(data=="\nSuccess\n")
{ $('.mainpane').load('Upgrade/'+'result.html'); }
else
{ alert(data); }
});
});

$("#check").click(function() {
$("#statusanim").css('visibility', 'visible');
var branch=$("#branch").val();
var build=$("#build").val();
var type=$("#type").val();
var image="c-series";
$("#status").load("upgradeStatusQuery.php",{Branch:branch,Build:build,Type:type,Image:image }, function() {
$("#statusanim").css('visibility', 'hidden');
});
});


</script>

