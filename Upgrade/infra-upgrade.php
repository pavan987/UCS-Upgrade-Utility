<?php
include 'session.php';
?>

<div class="content">
<h1> Upgrade UCSM Infrastructure firmware </h1>
<h2>( This upgrades infra firmware of registered testbed using autoinstall )</h2>
<form action="#" method="POST" id="upgrade">

<h2> Branch </h2>
<select name="branch" id="branch">
<option value="" selected="selected" >
Select
</option>
<option value="granada-builds">
Granada
</option>
<option value="granada_bw-builds">
Granada_Patch
</option>
<option value="granada_mr1-builds">
Granada_MR1
</option>
</select>

<br><br>

<h2> Build 
<span id="buildanim" style="visibility: hidden" ><img src="images/buildanim.gif" /><!-- Place at bottom of page --></span> </h2>
<select name="build" id="build">
</select>
<br><br>


<h2> Platform </h2>
<select name="platform" id="platform">
<option value="Mammoth">
Mammoth
</option>
<option value="3gfi">
3G-FI
</option>
<option value="mini">
UCS-MINI
</option>
</select>

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
<span id="statusbuild" style="visibility: hidden" ><img src="images/statusanim.gif" /><!-- Place at bottom of page --></span> </h2>
<input type="button" value=" Check " id="buildcheck" /> <span id="buildstatus"></span>


<br><br>
<h2>Sanity Status
<span id="statussanity" style="visibility: hidden" ><img src="images/statusanim.gif" /><!-- Place at bottom of page --></span> </h2>
<input type="button" value=" Check " id="sanitycheck" /> <span id="sanitystatus"></span>
<br><br>

<!--
<h2>Nightly Status
<span id="statusnightly" style="visibility: hidden" ><img src="images/statusanim.gif" /> Place at bottom of page </span> </h2>
<input type="button" value=" Check " id="nightlycheck" /> <span id="nightlystatus"></span>
<br><br> --!>

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
$.post("/Upgrade/upgrade-action.php",$("#upgrade").serialize()+'&Image=infra', function(data) {
if(data=="\nSuccess\n")
{ $('.mainpane').load('Upgrade/'+'result.html'); }
else
{ alert(data); }
});
});

$("#buildcheck").click(function() {
$("#statusbuild").css('visibility', 'visible');
var branch=$("#branch").val();
var build=$("#build").val();
var type=$("#type").val();
var image="infra";
var platform=$("#platform").val();
$("#buildstatus").load("upgradeStatusQuery.php",{Branch:branch,Build:build,Type:type,Image:image, platform:platform }, function() {
$("#statusbuild").css('visibility', 'hidden');
});
});

$("#sanitycheck").click(function() {
$("#statussanity").css('visibility', 'visible');
var branch=$("#branch").val();
var build=$("#build").val();
var platform=$("#platform").val();
var type= "sanity"
$("#sanitystatus").load("upgradeSanityQuery.php",{Branch:branch,Build:build,Type:type,platform:platform }, function() {
$("#statussanity").css('visibility', 'hidden');
});
});

$("#nightlycheck").click(function() {
$("#statusnightly").css('visibility', 'visible');
var branch=$("#branch").val();
var build=$("#build").val();
var type= "nightly"
$("#nightlystatus").load("upgradeSanityQuery.php",{Branch:branch,Build:build,Type:type }, function() {
$("#statusnightly").css('visibility', 'hidden');
});
});
</script>

