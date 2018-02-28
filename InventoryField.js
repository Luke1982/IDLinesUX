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
	function InventoryField(el, rootObj, params){
		var defaults 	= {
			"decimals" 	: 2,
			"curSep"	: ".",
			"decSep"	: ","
		};

		this.el 		= el,
		this.root 		= rootObj,
		this.u 			= rootObj.utils,
		this.formEl 	= this.u.findUp(this.el, ".slds-form-element"),
		this.helpCont	= this.formEl != undefined ? this.u.getFirstClass(this.formEl, "slds-form-element__help") : undefined,
		this.errorSet 	= false,
		this.errorMess  = this.el.hasAttribute("data-error-mess") ? this.el.getAttribute("data-error-mess") : "",
		this.type 		= this.getType(),
		this._val 		= _sanitizeNumberString(this.el.value),
		this.specialKeys= [",", ".", "backspace"],
		this.decimals 	= params.decimals || defaults.decimals,
		this.decSep 	= params.decSep || defaults.decSep,
		this.curSep 	= params.curSep || defaults.curSep;

		this.u.on(this.el, "jsInput", this.format, this);
	}

	InventoryField.prototype = {
		constructor : InventoryField,

		getType : function() {
			return this.el.hasAttribute("data-type") ? this.el.getAttribute("data-type") : false;
		},

		getFieldName : function() {
			var classes = this.el.classList;
			for (var i = 0; i < classes.length; i++) {
				if (classes[i].indexOf(this.root.inputPrefix) > -1)
					return classes[i].split("--")[1];
			}
		},

		isReadOnly : function() {
			return this.el.hasAttribute("readonly");
		},

		getData : function(type) {
			return this.el.getAttribute("data-" + type);
		},

		getValue : function() {
			if (this.getType() != "text")
				return Number(_sanitizeNumberString(this.el.value));
			else
				return this.el.value;
		},

		validate : function() {
			if (this.isReadOnly()) return true;
			var type = this.getType();
			switch(type) {
				case "number":
					return this.valNumber();
					break;
				case "currency":
					return _isCurrency(this._val);
					break;
			}
			return true;
		},

		valNumber : function() {
			toCheck = _sanitizeNumberString(this.el.value);
			if (!_isNumber(toCheck)) {
				return false;
			} else {
				var min = this.getData("min") != null ? Number(this.getData("min")) : (0 - Number.MAX_SAFE_INTEGER),
					max = this.getData("max") != null ? Number(this.getData("max")) : Number.MAX_SAFE_INTEGER;
				if (Number(toCheck) >= min && Number(toCheck) <= max)
					return true;
				else
					return false;
			}
		},

		format : function(e) {
			var type = this.getType();
			switch(type) {
				case "currency":
					if (e.type == "jsInput") {
						this.handleCurJsInput();
					} else if (e.type == "keyup" && !this.isReadOnly()) {
						this.handleCurKeyUp(e);
					}
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

		handleCurKeyUp : function(e) {
			if (_isNumber(e.key) && _decNum(this._val) < 2) {
				this._val = this._val + e.key;
			} else if (this.isSpecialKey(e.keyCode)) {
				if (e.key == "Backspace") {
					this._val = this._val.substring(0, this._val.length -1);
				} else if ((this._val.match(/\./g) || []).length < 1){
					this._val = this._val + ".";
				}
			}
			this.el.value = this.getCurConvertedVal();
		},

		handleCurJsInput : function() {
			this._val = this.el.value;
			this.el.value = this.getCurConvertedVal();
		},

		getCurConvertedVal: function() {
			return _makeCurr(this._val, 2, this.decSep, this.curSep);
		},

		isSpecialKey : function(code) {
			return keyCodeMap[code] == undefined ? false : true;
		}
	}

	/*
	 * Factory tools
	 */
	function _isNumber(val) {
		val = _sanitizeNumberString(val);
		return isNaN(val) ? false : true;
	}

	function _sanitizeNumberString(numberString) {
		numberString = isNaN(numberString) ? numberString : Number(numberString).toFixed(2),
		numberString = numberString.toString(),
		numberString = numberString.replace(/(,)([0-9]{1,2})$/g, ".$2").replace(/(,)([0-9]{3})/g, "$2").replace(/(\.)([0-9]{3})/g, "$2");
		return numberString.replace(/ /g, "").replace(/,/g, "");
	}

	function _isCurrency(val) {
		return _isNumber(_sanitizeNumberString(val));
	}

	/* n: the number
	   c: no. of decimals
	   d: decimal sep
	   t: thousands sep
	   */
	function _makeCurr(n, c, d, t){
		var n = n, 
			c = _decNum(n) == 0 ? 0 : 2, 
			d = d == undefined ? "." : d, 
			t = t == undefined ? "," : t, 
			s = n < 0 ? "-" : "", 
			i = String(parseInt(n = Math.abs(Number(n) || 0).toFixed(c))), 
			j = (j = i.length) > 3 ? j % 3 : 0;
			return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
	}

	/* Returns the number of decimals in a number */
	function _decNum(num) {
		var match = (''+num).match(/(?:\.(\d+))?(?:[eE]([+-]?\d+))?$/);
		if (!match) { return 0; }
		return Math.max(0, (match[1] ? match[1].length : 0) - (match[2] ? +match[2] : 0));
	}

	var keyCodeMap = {
		8 : "backspace",
		188 : ",",
		190 : ".",
		110 : "."
	}

	/*
	 * Export
	 */
	return InventoryField;
});