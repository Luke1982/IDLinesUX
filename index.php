<?php

ini_set("display_errors", 1);
error_reporting(E_ALL);

require_once('lib/Smarty/Smarty.class.php');
$smarty = new Smarty();

$test = file_get_contents('./data-structure/product-structure-existing-deploy.json');
$testarray = json_decode($test, true);

$smarty->assign('testarray', $testarray);

$smarty->display('idlines.tpl');

?>