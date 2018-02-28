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

	/**
	 * @class ldsCombobox
	 * @param {element}: Typically a wrapping element of an LDS combobox, like 'slds-combobox-picklist'
	 */
	function ldsCombobox(el, params) {
		/* Public attributes */
		this.el 	= el,
		this.input 	= el.getElementsByClassName("slds-combobox__input")[0],
		this.specialKeys = ["up","down","enter"],
		this.optionNodes = el.getElementsByClassName("slds-listbox__item"),
		this.active = false,
		this.curSel = null,
		this.curSelIndex = this.getCurSelIndex(),
		this.onSelect = typeof params.onSelect == "function" ? params.onSelect : false,
		this._val = this.optionNodes[this.curSelIndex].getAttribute("data-value");

		/* Instance listeners */
		_on(el, "mousedown", this.handleClick, this);
		_on(el, "click", this.trigger, this);
		_on(this.input, "focus", this.trigger, this);
		_on(this.input, "keyup", this.trigger, this);
		_on(this.input, "blur", this.close, this);
	}

	ldsCombobox.prototype = {
		constructor: ldsCombobox,

		/*
		 * Method: 'trigger'
		 * Is in response to any keyboard or mouse action that should trigger the combobox
		 *
		 * @param: Event object
		 */
		trigger: function(e) {
			if (!this.active) {
				this.open();
			} else {
				this.handleKeys(e);
			}
		},

		/*
		 * Method: 'open'
		 * Opens and activates the dropdown and selects the last selected (or first)
		 * item in the list
		 *
		 */
		open: function() {
			this.el.classList.add("slds-is-open");
			this.setOptionState(this.curSelIndex, "selected");
			this.active = true;
		},

		/*
		 * Method: 'close'
		 * Closes the dropdown. 
		 *
		 */
		close: function(e) {
			this.el.classList.remove("slds-is-open");
			this.active = false;
		},

		/*
		 * Method: 'handleClick'
		 * Searches upwards for a listbox item to see if this was an option
		 * Then de-selects all other options and selects the clicked one 
		 *
		 * @param: Event object
		 */
		handleClick: function(e) {
			var isOption = _findUp(e.target, ".slds-listbox__item");
			if (isOption != undefined) {
				var index = this.getIndexByNode(isOption);
				for (var i = 0; i < this.optionNodes.length; i++) {
					this.setOptionState(i, "unselected");
				}
				this.setOptionState(index, "selected");
				this.curSelIndex = index;
				this.select();
			}
		},

		/*
		 * Method: 'handleKeys'
		 * Tests if a special key was pressed and if so, passes it on
		 * to 'handleKey'
		 *
		 * @param: Event object
		 */
		handleKeys: function(e) {
			if (this.isSpecialKey(e.keyCode)) {
				this.handleKey(_getKey(e.keyCode));
			}
		},

		/*
		 * Method: 'handleKey'
		 * Tests the keyname being pressed and selects the according
		 * method
		 *
		 * @param: Keyname string
		 */
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

		/*
		 * Method: 'isSpecialKey'
		 * Tests if a keycode is in the list of special keys for the class
		 *
		 * @param: Keycode INT
		 */
		isSpecialKey: function(code) {
			if (window.dropdownKeycodeMap[code] !== undefined)
				return this.specialKeys.indexOf(window.dropdownKeycodeMap[code]) == -1 ? false : true;
			else
				return false;
		},

		/*
		 * Method: 'setOptionState'
		 * Sets the state of an option in the dropdown list. Updates both the
		 * visual frontend side as the instance properties
		 *
		 * @param: index: index of the nodelist of options
		 * @param: state: either "selected", or anything else
		 */
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

		/*
		 * Method: 'selectPrevious'
		 * Only used by keyboard. Selects the previous option if
		 * the current is not the first one.
		 *
		 */
		selectPrevious: function() {
			if (this.curSelIndex != 0) {
				this.setOptionState(this.curSelIndex, "unselected");
				this.curSelIndex--;
				this.setOptionState(this.curSelIndex, "selected");
			}
		},

		/*
		 * Method: 'selectNext'
		 * Only used by keyboard. Selects the next option if
		 * the current is not the last one.
		 *
		 */
		selectNext: function() {
			if (this.curSelIndex != this.optionNodes.length - 1) {
				this.setOptionState(this.curSelIndex, "unselected");
				this.curSelIndex++;
				this.setOptionState(this.curSelIndex, "selected");
			}
		},

		/*
		 * Method: 'select'
		 * Performs the actual select based on the instance property
		 * 'curSel'. Also closes the dropdown.
		 *
		 */
		select: function() {
			this._val = this.optionNodes[this.curSelIndex].getAttribute("data-value");
			this.input.value = this.curSel;
			this.close();

			if (this.onSelect)
				this.onSelect();
		},

		/*
		 * Method: 'getVal'
		 * Returns the 'hidden' currently selected value, similar to
		 * the 'value' property of a normal <option> element
		 *
		 */
		getVal: function() {
			return this._val;
		},

		/*
		 * Method: 'getIndexByNode'
		 * Searches through the list of DOM nodes in the dropdown
		 * and returns the index if there is a match
		 *
		 * @param: node (DOM)
		 */
		getIndexByNode: function(node) {
			for (var i = 0; i < this.optionNodes.length; i++) {
				if (node.isSameNode(this.optionNodes[i])) return i;
			}
		},
		/*
		 * Method: 'getCurSelIndex'
		 * Returns the index of the option that matches
		 * the value of the input field
		 *
		 */
		getCurSelIndex: function() {
			for (var i = 0; i < this.optionNodes.length; i++) {
				if (this.optionNodes[i].getElementsByClassName("slds-truncate")[0].innerHTML == this.input.value) return i;
			}
		}
	}

	/**
	  * Section with factory tools
	  */
	function _on(el,type,func,context) {
		el.addEventListener(type, func.bind(context));
	}

	function _getKey(code) {
		return window.dropdownKeycodeMap[code];
	}

	function _findUp(element, searchterm) {
		element = element.children[0] != undefined ? element.children[0] : element; // Include the current element
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

	/*
	 * Globals
	 */
	if (!window.hasOwnProperty("dropdownKeycodeMap")) {
		window.dropdownKeycodeMap = {
			38: "up",
			40: "down",
			37: "left",
			39: "right",
			27: "esc",
			9:  "tab",
			13: "enter"
		}
	}

	return ldsCombobox;

});