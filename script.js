window.addEventListener("load", function(){
	var block = document.getElementsByClassName("cbds-inventory-block")[0];
	window.block = new InventoryBlock(block, {
			"linesContClass" : "cbds-inventorylines",
			"lineClass" : "cbds-inventoryline",
			"linePrefix" : "cbds-inventoryline",
			"inputPrefix" : "cbds-inventoryline__input"
	});
});