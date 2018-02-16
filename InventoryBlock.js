/****
	* InventoryBlock
	* @author: MajorLabel <info@majorlabel.nl>
	* @license GNU
	*/
(function inventoryblockModule(factory){

	if (typeof define === "function" && define.amd) {
		define(factory);
	} else if (typeof module != "undefined" && typeof module.exports != "undefined") {
		module.exports = factory();
	} else {
		window["InventoryBlock"] = factory();
	}

})(function inventoryblockFactory(){

	/**
	 * @class InventoryBlock
	 * @param {element} (class: "cbds-inventory-block")
	 */
	function InventoryBlock(el){
		/* Public properties */
		this.el = el,
		this.linesContainer = el.getElementsByClassName("cbds-detail-lines")[0],
		this.inventoryLines = {},
		this.inventoryLines.seq = 0;

		// Constructor function
		_on(window, "click", this.handleClicks, this);
		this.startSortable();
		this.startLines();

	}

	InventoryBlock.prototype = {
		constructor	: InventoryBlock,

		handleClicks: function(e) {
			var functionElement = this.utils.findUp(e.target, "data-clickfunction");
			if (functionElement !== undefined) {
				switch (functionElement.getAttribute("data-clickfunction")) {
					case "expandAllLines":
						this.utils.expandAllLines();
						break;
					case "collAllLines":
						this.utils.collAllLines();
						break;
					case "insertNewLine":
						this.utils.insertNew(this);
						break;
					case "deleteAllLines":
						this.utils.deleteAllLines();
						break;
				}
			}
		},

		startSortable: function() {
			Sortable.create(this.linesContainer, {
				draggable: ".cbds-detail-line",
				handle: ".cbds-detail-line-dragtool",
				animation: 100
			});
		},

		startLines : function() {
			var lines = this.linesContainer.getElementsByClassName("cbds-detail-line");
			for (var i = 0; i < lines.length; i++) {
				var line = new InventoryLine(lines[i], this);
			}
		},

		/*
		 * Class utilities
		 */
		utils : {
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

			deleteAllLines : function() {
				for (prop in window.InventoryLines) {
					if (prop != "seq")
						window.InventoryLines[prop].delete();
				}
			},

			insertNew : function(root) {
				var template = document.getElementsByClassName("cbds-detail-line--template")[0];
				var container = document.getElementsByClassName("cbds-detail-lines")[0];
				var newNode = template.cloneNode(true);
				newNode.classList.remove("cbds-detail-line--template");
				container.appendChild(newNode);
				new InventoryLine(newNode, root);
			}
		}
	}

	/**
	  * Section with factory tools
	  */
	function _on(el,type,func,context) {
		el.addEventListener(type, func.bind(context));
	}

	function _off(el,type,func) {
		el.removeEventListener(type, func);
	}


	/*
	 * Export
	 */
	return InventoryBlock;

});