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
		this.specialKeys= [",", ".", "Backspace", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"],
		this.decimals 	= params.decimals || defaults.decimals,
		this.decSep 	= params.decSep || defaults.decSep,
		this.curSep 	= params.curSep || defaults.curSep,
		this.curr	= this.curr(this);

		this.u.on(this.el, "jsInput", this.format, this);
	}

	InventoryField.prototype = {
		constructor : InventoryField,

		getType : function() {
			return this.el.hasAttribute("data-type") ? this.el.getAttribute("data-type") : false;
		},

		getFieldName : function(prefix) {
			var classes = this.el.classList,
				prefix = prefix || this.root.inputPrefix;
			for (var i = 0; i < classes.length; i++) {
				if (classes[i].indexOf(prefix) > -1)
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
			if (this.getType() != "text") {
				return cbNumber.isCurr(this.el.value) ? cbNumber.curToNum(this.el.value) : this.el.value;
			} else {
				return this.el.value;
			}
		},

		update : function(value) {
			var type = this.getType();
			switch (type) {
				case "currency":
					try {
						if (!cbNumber.isFloat(value) && !cbNumber.isInt(value))
							throw value + " is not a correct number";
						else
							this._val = value;
							this.el.value = cbNumber.numToCurr(value);
					}
					catch(err) {
						console.log(err);
					}
					break;
			}
		},

		validate : function() {
			if (this.isReadOnly()) return true;
			var type = this.getType();
			switch(type) {
				case "number":
					return this.valNumber();
					break;
				case "currency":
					return cbNumber.isCurr(this.el.value);
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
			var key = keyCodeMap[e.keyCode];
			if (this.isSpecialKey(key) && cbNumber.isInt(key)) {
				this.curr.add(key);
			} else if (this.isSpecialKey(key) && !cbNumber.isInt(key)) {
				switch (key) {
					case "Backspace":
						if (this.curr.isLast("."))
							this.curr.remove(2);
						else
							this.curr.remove(1);
						break;
					case ".":
						if (this.curr.charNum(".") < 1)
							this.curr.add(".");
						break;
					case ",":
						if (this.curr.charNum(".") < 1)
							this.curr.add(".");
						break;
				}
			}
			this._val = this._val.replace(/^0*/, "");
			this.el.value = cbNumber.numToCurr(this._val || "0.00");
		},

		handleCurJsInput : function() {
			this._val = this.el.value;
			this.el.value = cbNumber.numToCurr(this._val);
		},

		curr : function(parent) {
			var isLast = function(digit) {
				return parent._val.indexOf(digit) == (parent._val.length-1) ? true : false;
			}
			var add = function(key) {
				parent._val = cbNumber.decimalNum(parent._val) < 2 ? parent._val + key : parent._val;
			}
			var remove = function(n) {
				parent._val = parent._val.substring(0, parent._val.length - n);
			}
			var charNum = function(c) {
				var r = c == "." || c == "," ? new RegExp("\\" + c, "g") : new RegExp(c, "g");
				return (parent._val.match(r) || []).length
			}

			return {
				"isLast" : isLast,
				"add" : add,
				"remove" : remove,
				"charNum" : charNum
			};
		},

		/*
		 * Method: 'isSpecialKey'
		 * Tests if a key is in the list of special keys for the class.
		 * Takes either a keyname from the keycodeMap or a keyCode
		 *
		 * @param: Keyname OR keyCode
		 */
		isSpecialKey: function(key) {
			return this.specialKeys.indexOf(key) != -1 || this.specialKeys.indexOf(keyCodeMap[key]) != -1 ? true : false;
		}
	}

	/*
	 * Factory tools
	 */
	function _isNumber(val) {
		val = _sanitizeNumberString(val),
		val = val == "" ? "This was an empty string" : val;
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

	var keyCodeMap = {8:"Backspace",9:"Tab",13:"Enter",16:"Shift",17:"Ctrl",18:"Alt",19:"Pause/Break",20:"Caps Lock",27:"Esc",32:"Space",33:"Page Up",34:"Page Down",35:"End",36:"Home",37:"Left",38:"Up",39:"Right",40:"Down",45:"Insert",46:"Delete",48:"0",49:"1",50:"2",51:"3",52:"4",53:"5",54:"6",55:"7",56:"8",57:"9",65:"A",66:"B",67:"C",68:"D",69:"E",70:"F",71:"G",72:"H",73:"I",74:"J",75:"K",76:"L",77:"M",78:"N",79:"O",80:"P",81:"Q",82:"R",83:"S",84:"T",85:"U",86:"V",87:"W",88:"X",89:"Y",90:"Z",91:"Windows",93:"Right Click",96:"Numpad 0",97:"Numpad 1",98:"Numpad 2",99:"Numpad 3",100:"Numpad 4",101:"Numpad 5",102:"Numpad 6",103:"Numpad 7",104:"Numpad 8",105:"Numpad 9",106:"Numpad *",107:"Numpad +",109:"Numpad -",110:"Numpad .",111:"Numpad /",112:"F1",113:"F2",114:"F3",115:"F4",116:"F5",117:"F6",118:"F7",119:"F8",120:"F9",121:"F10",122:"F11",123:"F12",144:"Num Lock",145:"Scroll Lock",182:"My Computer",183:"My Calculator",186:";",187:"=",188:",",189:"-",190:".",191:"/",192:"`",219:"[",220:"\\",221:"]",222:"'"};

	/*
	 * Export
	 */
	return InventoryField;
});