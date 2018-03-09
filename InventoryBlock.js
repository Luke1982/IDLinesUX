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
	function InventoryBlock(el, params){

		var defaults = {
			"linesContClass" : "cbds-inventorylines",
			"lineClass" : "cbds-inventoryline",
			"linePrefix" : "cbds-inventoryline",
			"inputPrefix" : "cbds-inventoryline__input",
			"aggrPrefix" : "cbds-inventoryaggr",
			"aggrInputPrefix" : "cbds-inventoryaggr__input"
		};

		params = params == undefined ? defaults : params;

		/* Public properties */
		this.linesContClass = params.linesContClass,
		this.lineClass = params.lineClass,
		this.linePrefix = params.linePrefix,
		this.inputPrefix = params.inputPrefix,
		this.aggrPrefix = params.aggrPrefix,
		this.aggrInputPrefix = params.aggrInputPrefix,
		this.el = el,
		this.linesContainer = el.getElementsByClassName(this.linesContClass)[0],
		this.inventoryLines = {},
		this.inventoryLines.seq = 0,
		this.countCont = this.utils.getFirstClass(el, "cbds-inventoryaggr--linecount"),
		this.aggrCont = this.utils.getFirstClass(el, this.aggrPrefix);

		// Aggregation fields
		this.fields = {};
		var inputs = el.getElementsByTagName("input"),
			r = new RegExp(this.aggrInputPrefix + "--[\\w]*", "g");
		for (var i = 0; i < inputs.length; i++) {
			if ((inputs[i].className.match(r) || []).length != 0) {
				var field = new InventoryField(inputs[i], this, {
					"decimals" : 2,
					"decSep" : window.userDecimalSeparator,
					"curSep" : window.userCurrencySeparator
				});
				this.fields[field.getFieldName(this.aggrInputPrefix)] = field;
			}
		}

		// Construction
		this.utils.on(window, "click", this.handleClicks, this);
		this.utils.on(this.aggrCont, "keyup", this.handleAggrInput, this);
		this.startSortable();
		this.startLines();
		ldsCheckbox.setUnique();

		var taxtypeInput = this.utils.getFirstClass(el, "cbds-inventory-block__input--taxtype");
		this.taxType = new ldsCombobox(this.utils.findUp(taxtypeInput, ".slds-combobox-picklist"), {
			"onSelect" : this.changeTaxType.bind(this)
		});
	}

	InventoryBlock.prototype = {
		constructor	: InventoryBlock,

		handleClicks: function(e) {
			var functionElement = this.utils.findUp(e.target, "data-clickfunction");
			if (functionElement !== undefined) {
				switch (functionElement.getAttribute("data-clickfunction")) {
					case "expandAllLines":
						this.expandAllLines();
						break;
					case "collAllLines":
						this.collAllLines();
						break;
					case "insertNewLine":
						this.insertNew(this);
						break;
					case "deleteAllLines":
						if (confirm("Are you sure you want to delete ALL lines?"))
							this.deleteAllLines();
						break;
				}
			}
		},

		handleAggrInput: function(e) {
			var isTaxOrFee = this.isTaxOrFee(e.target);
		},

		isTaxOrFee: function(el) {
			return el.className.match(/tax\d{1,2}$|fee\d{1,2}$/) == null ? false : true;
		},

		startSortable: function() {
			Sortable.create(this.linesContainer, {
				draggable: "." + this.lineClass,
				handle: ".cbds-detail-line-dragtool",
				animation: 100
			});
		},

		startLines : function() {
			var lines = this.linesContainer.getElementsByClassName(this.lineClass);
			for (var i = 0; i < lines.length; i++) {
				var line = new InventoryLine(lines[i], this);
			}
			this.updateCount();
		},

		expandAllLines : function() {
			this.setAllExtraStates(1);
		},

		collAllLines : function() {
			this.setAllExtraStates(0);
		},

		setAllExtraStates : function(state) {
			for (prop in this.inventoryLines) {
				if (typeof this.inventoryLines[prop].expandExtra == "function") {
					if (state == 1) this.inventoryLines[prop].expandExtra();
					if (state == 0) this.inventoryLines[prop].collExtra();
				}
			}
		},

		deleteAllLines : function() {
			for (prop in this.inventoryLines) {
				if (prop != "seq")
					this.inventoryLines[prop].delete();
			}
			this.updateCount();
		},

		insertNew : function() {
			var template = document.getElementsByClassName(this.lineClass + "--template")[0];
			var container = document.getElementsByClassName(this.linesContClass)[0];
			var newNode = template.cloneNode(true);
			newNode.classList.remove(this.lineClass + "--template");
			container.appendChild(newNode);
			new InventoryLine(newNode, this);
			this.updateCount();
		},

		updateCount : function() {
			this.countCont.innerHTML = this.el.getElementsByClassName(this.lineClass).length;
		},

		updateAggr : function() {
			this.calcGross();
			this.calcTotalDiscount();
			this.calcTotalTax();
			this.calcTotal();
		},

		calcGross : function() {
			this.fields.subtotal.update(this.getLinesSum("extgross"));
		},

		calcTotalDiscount : function() {
			this.fields.totaldiscount.update(this.getLinesSum("discount_total"));
		},

		calcTotalTax : function() {
			this.fields.taxtotal.update(this.getLineTaxes());
		},

		calcTotal : function() {
			this.fields.total.update(this.getLinesSum("linetotal"));
		},

		getLinesSum : function(fieldname) {
			var sum = 0;
			for (line in this.inventoryLines) {
				sum = sum + (this.inventoryLines[line].fields != undefined ? Number(this.inventoryLines[line].fields[fieldname]._val) : 0);
			}
			return sum;
		},

		getLineTaxes : function() {
			var sum = 0,
				r = new RegExp("tax[\\d]{1,2}-amount", "");
			for (line in this.inventoryLines) {
				for (field in this.inventoryLines[line].fields) {
					if ((field.match(r) || []).length > 0)
						sum = sum + Number(this.inventoryLines[line].fields[field]._val);
				}
			}
			return sum;
		},

		changeTaxType : function(val) {
			if (val == "individual") {
				this.utils.getFirstClass(this.el, "cbds-inventoryaggr__taxfees").classList.remove("active");
			} else if (val == "group") {
				this.utils.getFirstClass(this.el, "cbds-inventoryaggr__taxfees").classList.add("active");
			}
		},

		/*
		 * Class utilities
		 */
		utils : {
			/*
			 * Util: 'findUp'
			 * Returns the first element up the DOM that matches the search
			 *
			 * @param: element: 	the node to start from
			 * @param: searchterm: 	Can be a class (prefix with '.'), ID (prefix with '#')
			 *						or an attribute (default when no prefix)
			 */
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
			/*
			 * Util: 'getFirstClass'
			 * Returns the first element from the root that matches
			 * the classname
			 *
			 * @param: root: 		the node to start from
			 * @param: className: 	The classname to search for
			 */
			getFirstClass: function(root, className) {
				return root.getElementsByClassName(className)[0] != undefined ? root.getElementsByClassName(className)[0] : {};
			},
			/*
			 * Util: 'on'
			 * Adds an event listener
			 *
			 * @param: el: 			The node to attach the listener to
			 * @param: type: 		The type of event
			 * @param: func: 		The function to perform
			 * @param: context: 	The context to bind the listener to
			 */
			on: function(el,type,func,context) {
				el.addEventListener(type, func.bind(context));
			},
			/*
			 * Util: 'off'
			 * Removes an event listener
			 *
			 * @param: el: 			The node to remove the listener from
			 * @param: type: 		The type of event
			 * @param: func: 		The function to remove
			 */
			off: function(el,type,func) {
				el.removeEventListener(type, func);
			},
			/*
			 * Util: 'insertAfter'
			 * Inserts a new node after the given
			 *
			 * @param: referenceNode: 	The node to insert after
			 * @param: newNode: 		The node to insert
			 */
			insertAfter: function(referenceNode, newNode) {
				referenceNode.parentNode.insertBefore(newNode, referenceNode.nextSibling)
			},
			/*
			 * Util: 'deductPerc'
			 * deducts a percentage from a number
			 *
			 * @param: base: 		The base '100%' number
			 * @param: percentage: 	The percentage to deduct
			 */
			deductPerc: function(base, percentage) {
				return (base * (1 - (percentage / 100)));
			},
			/*
			 * Util: 'getPerc'
			 * Returns a percentage of a base no.
			 *
			 * @param: base: 		The base '100%' number
			 * @param: percentage: 	The percentage to return
			 */
			getPerc: function(base, percentage) {
				return base * (percentage / 100);
			}
		}
	}

	/*
	 * Export
	 */
	return InventoryBlock;

});