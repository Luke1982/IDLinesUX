<?php

require_once('lib/Smarty/Smarty.class.php');
$smarty = new Smarty();

$test = file_get_contents('./data-structure/block-structure.json');
$testarray = json_decode($test, true);

$smarty->assign('inventoryblock', $testarray);

$smarty->display('idlines.tpl');

?>