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
		this.el 	= el,
		this.input 	= el.getElementsByClassName("slds-combobox__input")[0],
		this.specialKeys = ["up","down","enter"],
		this.optionNodes = el.getElementsByClassName("slds-listbox__item"),
		this.active = false,
		this.curSel = null,
		this.curSelIndex = 0;

		/* Instance listeners */
		_on(el, "click", this.handleClick, this);
		_on(this.input, "focus", this.trigger, this);
		_on(this.input, "keyup", this.trigger, this);
		_on(this.input, "blur", this.close, this);
	}

	ldsCombobox.prototype = {
		constructor: ldsCombobox,

		trigger: function(e) {
			if (!this.active) {
				this.open();
			} else {
				this.handleKeys(e);
			}
		},

		open: function() {
			this.el.classList.add("slds-is-open");
			this.setOptionState(this.curSelIndex, "selected");
			this.active = true;
		},

		close: function() {
			var _this = this;
			window.setTimeout(function(){
				_this.el.classList.remove("slds-is-open");
				_this.active = false;
			},200);
		},

		handleClick: function(e) {
			var isOption = Utils.findUp(e.target, ".slds-listbox__item");
			if (isOption != undefined) {
				this.curSel = isOption.getElementsByClassName("slds-truncate")[0].innerText;
				this.select();
			}
		},

		handleKeys: function(e) {
			if (this.isSpecialKey(e.keyCode)) {
				this.handleKey(_getKey(e.keyCode));
			}
		},

		handleKey: function(keyName) {
			switch(keyName) {
				case "up":
					this.selectPrevious();
					break;
				case "down":
					this.selectNext();
					break;
				case "enter":
					this.select();
					break;
			}
		},

		isSpecialKey: function(code) {
			if (window.keycodeMap[code] !== undefined)
				return this.specialKeys.indexOf(window.keycodeMap[code]) == -1 ? false : true;
			else
				return false;
		},

		setOptionState(index, state) {
			if (state == "selected") {
				this.optionNodes[index].children[0].classList.add("slds-has-focus");
				this.curSel = this.optionNodes[index].getElementsByClassName("slds-truncate")[0].innerText;
				this.input.value = this.curSel;
			} else {
				this.optionNodes[index].children[0].classList.remove("slds-has-focus");
				this.curSel = "";
			}
		},

		selectPrevious: function() {
			if (this.curSelIndex != 0) {
				this.setOptionState(this.curSelIndex, "unselected");
				this.curSelIndex--;
				this.setOptionState(this.curSelIndex, "selected");
			}
		},

		selectNext: function() {
			if (this.curSelIndex != this.optionNodes.length - 1) {
				this.setOptionState(this.curSelIndex, "unselected");
				this.curSelIndex++;
				this.setOptionState(this.curSelIndex, "selected");
			}
		},

		select: function() {
			this.input.value = this.curSel;
			this.close();
		}
	}

	/**
	  * Section with factory tools
	  */
	function _on(el,type,func,context) {
		el.addEventListener(type, func.bind(context));
	}

	function _getKey(code) {
		return window.keycodeMap[code];
	}

	return ldsCombobox;

});