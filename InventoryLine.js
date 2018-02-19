/****
	* InventoryLine
	* @author: MajorLabel <info@majorlabel.nl>
	* @license GNU
	*/
(function inventorylineModule(factory){

	if (typeof define === "function" && define.amd) {
		define(factory);
	} else if (typeof module != "undefined" && typeof module.exports != "undefined") {
		module.exports = factory();
	} else {
		window["InventoryLine"] = factory();
	}

})(function inventorylineFactory(){

	/**
	 * @class InventoryLine
	 * @param {element}
	 * @param {root} : InventoryBlock instance that is parent
	 */
	function InventoryLine(el, rootObj){
		/* Public properties */
		this.el 		= el,
		this.root		= rootObj,
		this.extraLine	= this.root.utils.getFirstClass(el, "cbds-detail-line__extra"),
		this.extraTool 	= _getTool(el, "extra"),
		this.comboBoxes	= [],
		this.fields		= {
			"cost_price"		: this.root.utils.getFirstClass(el, "cbds-product-line-cost_price"),
			"discount_amount"	: this.root.utils.getFirstClass(el, "cbds-product-line-discount_amount"),
			"discount_type"		: this.root.utils.getFirstClass(el, "cbds-product-line-discount_type"),
			"quantity"			: this.root.utils.getFirstClass(el, "cbds-product-line-quantity"),
			"discount_total"	: this.root.utils.getFirstClass(el, "cbds-product-line-discount_total")
		};

		/* Private properties */
		var copyTool 	= _getTool(el, "copy"),
			delTool 	= _getTool(el, "delete"),
			comboBoxes	= el.getElementsByClassName("slds-combobox-picklist"),
			_this 		= this;

		/* Instance Constructor */
		var construct 	= function(me) {
			me.id = me.root.inventoryLines.seq + 1,
			me.root.inventoryLines.seq++,
			me.root.inventoryLines[me.id] = me;
			new ProductAutocomplete(me.root.utils.getFirstClass(me.el, "cbds-product-search"), me.root);
			for (var i = 0; i < comboBoxes.length; i++) {
				me.comboBoxes.push(new ldsCombobox(comboBoxes[i]));
			}
		}
		construct(this);

		/* Instance listeners */
		this.root.utils.on(copyTool, "click", this.copy, this);
		this.root.utils.on(delTool, "click", this.delete, this);
		this.root.utils.on(this.extraTool, "click", this.toggleExtra, this);
		this.root.utils.on(el, "input", this.handleInput, this);
	}

	InventoryLine.prototype = {
		constructor	: InventoryLine,

		copy 		: function(){
						var original = this.el,
							newNode = original.cloneNode(true);

						this.root.utils.insertAfter(original, newNode);
						new InventoryLine(newNode, this.root);
					},

		delete 		: function() {
						this.el.parentNode.removeChild(this.el);
						this.root.utils.off(this.extraTool, "click", this.toggleExtra);
						delete this.root.inventoryLines[this.id];

						this.el = null;
					},

		toggleExtra : function() {
						this.extraLine.classList.toggle("cbds-detail-line__extra--expanded");
						this.extraTool.children[0].classList.toggle("cbds-exp-coll-icon--expanded");
					},

		expandExtra : function() {
						this.extraLine.classList.add("cbds-detail-line__extra--expanded");
						this.extraTool.children[0].classList.add("cbds-exp-coll-icon--expanded");
					},

		collExtra 	: function() {
						this.extraLine.classList.remove("cbds-detail-line__extra--expanded");
						this.extraTool.children[0].classList.remove("cbds-exp-coll-icon--expanded");
					},
		handleInput	: function(e) {
						var inputFunctions = e.target.hasAttribute("data-inputfunc") ? e.target.getAttribute("data-inputfunc") : "";
						inputFunctions = inputFunctions.indexOf(",") == -1 ? inputFunctions : inputFunctions.split(",");
						if (typeof inputFunctions == "object")
							for (var i = 0; i < inputFunctions.length; i++) {
								this.selectInputHandler(inputFunctions[i]);
							}
						else
							this.selectInputHandler(inputFunctions);
		},
		selectInputHandler : function(funcName) {
						switch(funcName) {
							case "updateDiscountAmount":
								this.updateDiscount();
								break;
						}
		},
		updateDiscount : function() {
						var unitCost 	= Number(this.fields.cost_price.value),
							discAmount 	= Number(this.fields.discount_amount.value),
							discType 	= this.fields.discount_type.value,
							qty			= Number(this.fields.quantity.value),
							discTotal	= 0;

						if (discType == "( -/- )") {
							discTotal = (qty * unitCost) - discAmount;
						} else {
							discTotal = _deductPerc((qty * unitCost), discAmount);
						}

						this.fields.discount_total.value = discTotal;
		}
	}

	/**
	  * Section with factory tools
	  */

	function _getTool(root, sort) {
		var tool = root.getElementsByClassName("cbds-detail-line-" + sort + "tool")[0];
		return tool === undefined ? document.createElement("div") : tool;
	}

	function _deductPerc(base, percentage) {
		return (base * (1 - (percentage / 100)));
	}

	/*
	 * Export
	 */
	return InventoryLine;

});