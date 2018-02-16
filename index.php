<?php

require_once('lib/Smarty/Smarty.class.php');
$smarty = new Smarty();

$line1 = array(
	'meta' 		=> array(
		'image' 			=> 'images/cola.jpg',
		'name'				=> 'Cola',
		'quantity'			=> 1,
		'discount_type' 	=> 'p',
		'discount_amount'	=> 0.5,
		'line_total'		=> 18.5,
		'divisible'			=> true,
		'comments'			=> 'A comment'
	),
	'pricing'	=> array(
		'unit_cost' 		=> 90,
		'line_cost'			=> 180,
		'list_price'		=> 15
	),
	'logistics'	=> array(
		'units_delrec'		=> 2,
		'qty_in_stock'		=> 9,
		'curr_ordered'		=> 3
	),
	'taxes'		=> array(
		'tax1'		=> array(
						'percent'	=> 21,
						'amount'	=> 200
				),
		'tax2'		=> array(
						'percent'	=> 6,
						'amount'	=> 12
				),
		'tax3'		=> array(
						'percent'	=> 1,
						'amount'	=> 8.3
				),
	),
	'custom'	=> array(
		'color' 	=> array(
						'type' 		=> 'dropdown',
						'available' => array('red', 'white', 'blue'),
						'selected'	=> 'blue'
				),
		'size' 	=> array(
						'type' 		=> 'dropdown',
						'available' => array('S', 'M', 'L'),
						'selected'	=> 'M'
				),
		'tag' 	=> array(
						'type' 		=> 'text',
						'value'		=> 'I am text'
				),
	)
);

$testarray = array();
$testarray[] = $line1;
$smarty->assign('testarray', $testarray);

$smarty->display('idlines.tpl');

?>