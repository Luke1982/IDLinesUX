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
		this.comboBoxes	= [];

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
						this.root.inventoryLines[this.id];

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
					}
	}

	/**
	  * Section with factory tools
	  */

	function _getTool(root, sort) {
		var tool = root.getElementsByClassName("cbds-detail-line-" + sort + "tool")[0];
		return tool === undefined ? document.createElement("div") : tool;
	}

	/*
	 * Export
	 */
	return InventoryLine;

});