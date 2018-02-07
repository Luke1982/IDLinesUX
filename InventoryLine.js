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
	 */
	function InventoryLine(el){
		this.el = el;

		/* Properties */
		var copyTool = _getTool(el, "copy");

		/* Instance listeners */
		_on(copyTool, "click", this.copy, this);

	}

	InventoryLine.prototype = {
		constructor: InventoryLine,

		copy : function(){
			var original = this.el,
				newNode = original.cloneNode(true);

			_insertAfter(original, newNode);
		},
	}

	/**
	  * Section with factory tools
	  */
	function _getTool(root, sort) {
		var tool = root.getElementsByClassName("cbds-detail-line-" + sort + "tool")[0];
		return tool === undefined ? document.createElement("div") : tool;
	}
	function _on(el,type,func,context) {
		el.addEventListener(type, func.bind(context));
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

	return InventoryLine;

});