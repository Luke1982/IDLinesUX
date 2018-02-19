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
		this.errorMess  = this.el.hasAttribute("data-error-mess") ? this.el.getAttribute("data-error-mess") : "",
		this.type 		= this.getType(),
		this.val 		= "";

		if (this.type == "currency") {
			this.u.on(this.el, "keyup", this.maskCurField, this);
		}
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
				case "currency":
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
		},

		maskCurField : function(e) {
			if (_isNumber(e.key) || e.keyCode == 8 || e.keyCode == 188 || e.keyCode == 190)
				this.val = e.key != "Backspace" ? this.val + e.key : this.val.substring(0, this.val.length -1);
				var maskedVal = _makeCurr(_sanitizeNumberString(this.val), 2, window.userDecimalSeparator, window.userCurrencySeparator);
				this.el.value = maskedVal;

			console.log(this.val);
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
			return number.replace(window.userDecimalSeparator, ".").replace(",", "");
		}
	}

	function _makeCurr(n, c, d, t){
		var c = isNaN(c = Math.abs(c)) ? 2 : c, 
		d = d == undefined ? "." : d, 
		t = t == undefined ? "," : t, 
		s = n < 0 ? "-" : "", 
		i = String(parseInt(n = Math.abs(Number(n) || 0).toFixed(c))), 
		j = (j = i.length) > 3 ? j % 3 : 0;
		return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
	}

	/*
	 * Export
	 */
	return InventoryField;
});