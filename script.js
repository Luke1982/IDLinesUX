window.addEventListener("click", handleClicks);

function handleClicks(e) {
	var functionElement = Utils.findUp(e.target, "data-clickfunction");
	if (functionElement !== undefined) {
		switch (functionElement.getAttribute("data-clickfunction")) {
			case "toggleExtra":
				Utils.toggleExtra(functionElement, e.target);
				break;
		}
	}
}

window.addEventListener("load", function(){
	startSort();
});

function startSort() {
	var container = document.getElementsByClassName("cbds-detail-block")[0];
	var sortable = Sortable.create(container, {
		draggable: ".cbds-detail-line",
		handle: ".cbds-detail-line-dragtool",
		animation: 100
	});
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
	},
	toggleExtra : function(functionElement, sourceElement) {
		var lineRoot = this.findUp(functionElement, ".cbds-detail-line");
		var extraLine = lineRoot.getElementsByClassName("cbds-detail-line__extra")[0];
		var expandIcon = lineRoot.getElementsByClassName("cbds-exp-coll-icon")[0];
		extraLine.classList.toggle("cbds-detail-line__extra--expanded");
		expandIcon.classList.toggle("cbds-exp-coll-icon--expanded");
	}
};