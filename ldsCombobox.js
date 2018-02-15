/****
	* ldsCombobox
	* @author: MajorLabel <info@majorlabel.nl>
	* @license GNU
	*/
(function ldscomboboxModule(factory){

	if (typeof define === "function" && define.amd) {
		define(factory);
	} else if (typeof module != "undefined" && typeof module.exports != "undefined") {
		module.exports = factory();
	} else {
		window["ldsCombobox"] = factory();
	}

})(function ldscomboboxFactory(){

	function ldsCombobox(el) {
		el.addEventListener("click", this.handleClick.bind(this));

		this.el 	= el,
		this.input 	= el.getElementsByClassName("slds-combobox__input")[0];
	}

	ldsCombobox.prototype = {
		constructor		: ldsCombobox,

		handleClick		: function(e) {
			var isOption = Utils.findUp(e.target, ".slds-listbox__item");
			if (isOption)
				var value = isOption.getElementsByClassName("slds-truncate")[0].innerText;
				this.input.value = value;
		}
	}

	return ldsCombobox;

});