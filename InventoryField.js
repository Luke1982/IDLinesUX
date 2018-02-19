/****
	* InventoryField
	* @author: MajorLabel <info@majorlabel.nl>
	* @license GNU
	*/
(function inventoryfieldModule(factory){

	if (typeof define === "function" && define.amd) {
		define(factory);
	} else if (typeof module != "undefined" && typeof module.exports != "undefined") {
		module.exports = factory();
	} else {
		window["InventoryField"] = factory();
	}

})(function inventoryfieldFactory(){

	/**
	 * @class InventoryField
	 * @param {element}
	 */
	function InventoryField(el, rootObj){
		this.el 		= el,
		this.root 		= rootObj,
		this.u 			= rootObj.utils,
		this.formEl 	= this.u.findUp(this.el, ".slds-form-element"),
		this.helpCont	= this.formEl != undefined ? this.u.getFirstClass(this.formEl, "slds-form-element__help") : undefined,
		this.errorSet 	= false,
		this.errorMess  = this.el.hasAttribute("data-error-mess") ? this.el.getAttribute("data-error-mess") : "";
	}

	InventoryField.prototype = {
		constructor : InventoryField,

		getType : function() {
			return this.el.hasAttribute("data-type") ? this.el.getAttribute("data-type") : false;
		},

		validate : function() {
			var type = this.getType();
			switch(type) {
				case "number":
					return _isNumber(this.el.value);
					break;
			}
		},

		setState : function(state) {
			switch(state) {
				case "error":
					this.setError();
					break;
				case "normal":
					this.setNormal();
					break;
			}
		},

		setError : function() {
			if (!this.errorSet)
				this.formEl.classList.add("slds-has-error");
				this.setHelp(this.errorMess);
				this.errorSet = true;
		},

		setNormal : function() {
			if (this.errorSet)
				this.formEl.classList.remove("slds-has-error");
				this.setHelp("");
				this.errorSet = false;
		},

		setHelp : function(text) {
			this.helpCont.innerHTML = text;
		}
	}

	/*
	 * Factory tools
	 */
	function _isNumber(val) {
		val = _sanitizeNumberString(val);
		return isNaN(val) ? false : true;
	}

	function _sanitizeNumberString(number) {
		if (window.userDecimalSeparator != ".") {
			return number.replace(window.userDecimalSeparator, ".");
		}
	}

	/*
	 * Export
	 */
	return InventoryField;
});