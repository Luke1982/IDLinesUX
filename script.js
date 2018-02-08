window.addEventListener("click", handleClicks);

function handleClicks(e) {
	var functionElement = Utils.findUp(e.target, "data-clickfunction");
	if (functionElement !== undefined) {
		switch (functionElement.getAttribute("data-clickfunction")) {
			case "expandAllLines":
				Utils.expandAllLines();
				break;
			case "collAllLines":
				Utils.collAllLines();
				break;
			case "insertNewLine":
				Utils.insertNew();
				break;
		}
	}
}

window.addEventListener("load", function(){
	startSort();
	startLines();
	startProductAutoComplete();
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
	var lines = document.getElementsByClassName("cbds-detail-block")[0].getElementsByClassName("cbds-detail-line");
	for (var i = 0; i < lines.length; i++) {
		var line = new InventoryLine(lines[i]);
	}
}

function startProductAutoComplete() {
	var acs = document.getElementsByClassName("cbds-detail-block")[0].getElementsByClassName("cbds-product-search");
	for (var i = 0; i < acs.length; i++) {
		var ac = new ProductAutocomplete(acs[i]);
	}
}

var Utils = {

	findUp : function(element, searchterm) {
		element = element.children[0] != undefined ? element.children[0] : element; // Include the current element
		while (element = element.parentElement) {
			if ( (searchterm.charAt(0) === "#" && element.id === searchterm.slice(1) )
				|| ( searchterm.charAt(0) === "." && element.classList.contains(searchterm.slice(1) ) 
				|| ( element.hasAttribute(searchterm) ))) {
				return element;
			} else if (element == document.body) {
				break;
			}
		}
	},

	expandAllLines : function() {
		this.setAllExtraStates(1);
	},

	collAllLines : function() {
		this.setAllExtraStates(0);
	},

	setAllExtraStates : function(state) {
		for (prop in window.InventoryLines) {
			if (typeof window.InventoryLines[prop].expandExtra == "function") {
				if (state == 1) window.InventoryLines[prop].expandExtra();
				if (state == 0) window.InventoryLines[prop].collExtra();
			}
		}
	},

	insertNew : function() {
		var template = document.getElementsByClassName("cbds-detail-line--template")[0];
		var container = document.getElementsByClassName("cbds-detail-block")[0];
		var newNode = template.cloneNode(true);
		newNode.classList.remove("cbds-detail-line--template");
		container.appendChild(newNode);
		new InventoryLine(newNode);
	}

};