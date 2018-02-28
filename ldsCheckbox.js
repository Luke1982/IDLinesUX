/****
	* ldsCombobox
	* @author: MajorLabel <info@majorlabel.nl>
	* @license GNU
	*/
(function ldscheckboxModule(factory){

	if (typeof define === "function" && define.amd) {
		define(factory);
	} else if (typeof module != "undefined" && typeof module.exports != "undefined") {
		module.exports = factory();
	} else {
		window["ldsCheckbox"] = factory();
	}

})(function ldscheckboxFactory(){

	/**
	 * @class ldsCheckbox
	 */
	function ldsCheckbox() {
		/* Public attributes */
	}

	/*
	 * Static methods
	 */
	ldsCheckbox.setUnique = function() {
		var ldsCheckboxes = document.getElementsByClassName("slds-checkbox");
		for (var i = 0; i < ldsCheckboxes.length; i++) {
			ldsCheckboxes[i].getElementsByTagName("input")[0].id = "slds-checkbox-" + i,
			ldsCheckboxes[i].getElementsByClassName("slds-checkbox__label")[0].setAttribute("for", "slds-checkbox-" + i);
		}
	}

	ldsCheckbox.prototype = {
		constructor: ldsCheckbox,
	}

	/*
	 * Export
	 */
	return ldsCheckbox;

});