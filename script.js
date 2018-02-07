window.addEventListener("load", function(){
	startSort();
	startLines();
});

function startSort() {
	var container = document.getElementsByClassName("cbds-detail-block")[0];
	var sortable = Sortable.create(container, {
		draggable: ".cbds-detail-line",
		handle: ".cbds-detail-line-dragtool",
		animation: 100
	});
}

function startLines() {
	var lines = document.getElementsByClassName("cbds-detail-line");
	for (var i = 0; i < lines.length; i++) {
		new InventoryLine(lines[i]);
	}
}

var Utils = {
	findUp : function(element, searchterm) {
		while (element = element.parentElement) {
			if ( (searchterm.charAt(0) === "#" && element.id === searchterm.slice(1) )
				|| ( searchterm.charAt(0) === "." && element.classList.contains(searchterm.slice(1) ) 
				|| ( element.hasAttribute(searchterm) ))) {
				return element;
			} else if (element == document.body) {
				break;
			}
		}
	}
};