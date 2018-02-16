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
	function InventoryLine(el, rootBlock){
		/* Public properties */
		this.el 		= el,
		this.root		= rootBlock,
		this.extraLine	= _getFirstClass(el, "cbds-detail-line__extra"),
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
			new ProductAutocomplete(_getFirstClass(me.el, "cbds-product-search"));
			for (var i = 0; i < comboBoxes.length; i++) {
				me.comboBoxes.push(new ldsCombobox(comboBoxes[i]));
			}
		}
		construct(this);

		/* Instance listeners */
		_on(copyTool, "click", this.copy, this);
		_on(delTool, "click", this.delete, this);
		_on(this.extraTool, "click", this.toggleExtra, this);

	}

	InventoryLine.prototype = {
		constructor	: InventoryLine,

		copy 		: function(){
						var original = this.el,
							newNode = original.cloneNode(true);

						_insertAfter(original, newNode);
						new InventoryLine(newNode, this.root);
					},

		delete 		: function() {
						this.el.parentNode.removeChild(this.el);
						_off(this.extraTool, "click", this.toggleExtra);
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

	function _getFirstClass(root, className) {
		return root.getElementsByClassName(className)[0];
	}

	function _on(el,type,func,context) {
		el.addEventListener(type, func.bind(context));
	}

	function _off(el,type,func) {
		el.removeEventListener(type, func);
	}

	function _findUp(element, searchterm) {
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

	function _insertAfter(referenceNode, newNode) {
		referenceNode.parentNode.insertBefore(newNode, referenceNode.nextSibling)
	}

	/*
	 * Export
	 */
	return InventoryLine;

});