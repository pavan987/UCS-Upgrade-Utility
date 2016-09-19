<?php 
include $_SERVER["DOCUMENT_ROOT"].'/configure/session.php';
include $_SERVER["DOCUMENT_ROOT"].'/header.php';
?>
<div class="leftpane">
<h3> Firmware Upgrade </h3>
<ul>
<li> <a class="ajaxTrigger" load="infra-upgrade.php" href="#"> Infra Upgrade</a> </li>
<li> <a class="ajaxTrigger" load="blade-upgrade.php" href="#"> B-Server Upgrade</a> </li>
<li> <a class="ajaxTrigger" load="rack-upgrade.php" href="#"> C-Server Upgrade</a> </li>
<li> <a class="ajaxTrigger" load="m-upgrade.php" href="#"> Me-Server Upgrade</a> </li>
</ul>
</div>

<div class="mainpane">
<?php include 'Upgrade/infra-upgrade.php' ?>
</div>
<script>
$(document).ready(function(){
  $('.ajaxTrigger').click(function(){
    var pageName = $(this).attr('load');
    $('.mainpane').load('Upgrade/'+pageName);
  });
});
</script>
</body>
</html>
