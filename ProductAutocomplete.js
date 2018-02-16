/****
	* ProductAutocomplete
	* @author: MajorLabel <info@majorlabel.nl>
	* @license GNU
	*/
(function productautocompleteModule(factory){

	if (typeof define === "function" && define.amd) {
		define(factory);
	} else if (typeof module != "undefined" && typeof module.exports != "undefined") {
		module.exports = factory();
	} else {
		window["ProductAutocomplete"] = factory();
	}

})(function productautocompleteFactory(){

	/**
	 * @class InventoryLine
	 * @param {element}
	 * @param {function}: 	Callback for custom implementations. Will receive an object with
	 *						the root autocomplete node and all the result data
	 */
	function ProductAutocomplete(el, callback){
		this.el = el,
		this.specialKeys = ["up","down","esc","enter"],
		this.threshold = 3,
		this.input = el.getElementsByTagName("input")[0],
		this.source = "sample-products.json",
		this.active = false,
		this.resultContainer,
		this.resultBox,
		this.lookupContainer = _getByCl(el,"slds-combobox-lookup"),
		this.currentResults = [],
		this.callback = typeof callback === "function" ? callback : false;

		/* Instance listeners */
		_on(this.input, "keyup", this.trigger, this);
		_on(this.input, "blur", this.delayedClear, this);
	}

	ProductAutocomplete.prototype = {
		constructor : ProductAutocomplete,

		trigger		: function(e) {
			var isSpecialKey = this.isSpecialKey(e.keyCode);
			var term = this.input.value;
			
			if (!isSpecialKey && term.length > this.threshold)
				this.getResults(term);
			else if (term.length < this.threshold)
				this.clear();
			else if (isSpecialKey)
				this.handleKeyInput(e.keyCode);
		},

		isSpecialKey: function(code) {
			if (window.keycodeMap[code] !== undefined)
				return this.specialKeys.indexOf(window.keycodeMap[code]) == -1 ? false : true;
			else
				return false;
		},

		getResults: function(term) {
			var _this = this,
				r = new XMLHttpRequest();
			r.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var res = JSON.parse(this.responseText);
					_this.processResult(res);
				}
			}
			r.open("GET", this.source, true);
			r.send();
		},

		processResult: function(res) {
			// Build and attach container
			if (!this.active) {
				this.resultBox = this.buildResultBox();
				this.attachResultBox(this.resultBox);
				this.resultContainer = this.buildResultContainer();
				this.resultBox.appendChild(this.resultContainer);
				this.active = true;
			}

			// Build results
			var results = this.buildResults(res);
		},

		buildResultBox: function() {
			var div = _createEl("div", "");
			div.setAttribute("role", "listbox");
			return div;
		},

		buildResultContainer: function() {
			var ul 	= _createEl("ul", "slds-listbox slds-listbox_vertical slds-dropdown slds-dropdown_fluid");
			ul.setAttribute("role", "presentation");
			return ul;
		},

		attachResultBox: function(containerDiv) {
			this.lookupContainer.appendChild(containerDiv);
			this.lookupContainer.classList.add("slds-is-open");
			this.lookupContainer.setAttribute("aria-expanded", "true");
		},

		removeResultBox: function() {
			this.lookupContainer.classList.remove("slds-is-open");
			this.lookupContainer.removeAttribute("aria-expanded", "true");
			this.lookupContainer.removeChild(this.resultBox);
		},

		buildResults: function(results) {
			// Empty all first
			this.resultContainer.innerHTML = "";
			this.currentResults = [];

			for (var i = 0; i < results.length; i++) {
				this.attachResultToContainer(this.buildResult(results[i]));
			}

			// Pre-select the first result
			_getByCl(this.currentResults[0].node, "slds-listbox__option").classList.add("slds-has-focus");
			this.currentResults[0].selected = true;
		},

		buildResult: function(result) {
			var media = this.buildResultMedia(result.meta.name, [
				{"label" : "Manufacturer No.", "value" : result.meta.mfr_no},
				{"label" : "Vendor No.", "value" : result.meta.ven_no}
			]);

			var li = _createEl("li", "slds-listbox__item slds-border_bottom");
			li.setAttribute("role", "presentation");
			li.appendChild(media);
			
			this.currentResults.push({
				"obj" 		: result,
				"node"		: li,
				"selected"	: false
			});

			_on(li, "click", this.click, this);
			_on(li, "mouseover", this.onResultHover, this);

			return li;
		},

		buildResultMedia: function(name, lines) {
			var mediaBody = _createEl("div", "slds-media__body");
			var listboxText = _createEl("span", "slds-listbox__option-text slds-listbox__option-text_entity slds-text-title_caps cbds-product-search-title", name);
			var listboxMetas = this.buildListboxMetas(lines);

			mediaBody.appendChild(listboxText);
			for (var i = 0; i < listboxMetas.length; i++) {
				mediaBody.appendChild(listboxMetas[i]);
			}

			var media = _createEl("div", "slds-media slds-listbox__option slds-listbox__option_entity slds-listbox__option_has-meta");
			media.setAttribute("role", "option");
			media.appendChild(mediaBody);
			return media;
		},

		buildListboxMetas: function(lines) {
			var returnLines = [];
			for (var i = 0; i < lines.length; i++) {
				returnLines.push(this.buildListboxMeta(lines[i]));
			}
			return returnLines;
		},

		buildListboxMeta: function(line) {
			var grid = _createEl("div", "slds-grid slds-has-flexi-truncate slds-p-top_xx-small");
			var title = _createEl("div", "slds-col slds-size_1-of-2 slds-p-left_none slds-text-title slds-truncate", line.label);
			var value = _createEl("div", "slds-col slds-size_1-of-2 slds-p-left_none", line.value);
			grid.appendChild(title);
			grid.appendChild(value);
			
			var meta = _createEl("span", "slds-listbox__option-meta slds-listbox__option-meta_entity");
			meta.appendChild(grid);
			return meta;
		},

		attachResultToContainer: function (resultLi) {
			this.resultContainer.appendChild(resultLi);
		},

		onResultHover : function(e) {
			var result = _findUp(e.target, "slds-listbox__item");
			for (var i = 0; i < this.currentResults.length; i++) {
				this.setResultState(i,"");
			}
			this.setResultState(this.getResultIndexByNode(result),"slds-has-focus");
		},

		clear: function() {
			if (this.active)
				this.removeResultBox();
				this.destroyResultListeners();
				this.currentResults = [];
				this.active = false;
		},

		delayedClear : function() {
			var _this = this;
			window.setTimeout(function(){_this.clear();},150);
		},

		destroyResultListeners: function() {
			for (var i = 0; i < this.currentResults.length; i++) {
				_off(this.currentResults[i].node, "click", this.click, this);
				_on(this.currentResults[i].node, "mouseover", this.onResultHover, this);
			}
		},

		handleKeyInput : function(keyCode) {
			if (this.active) {
				var key = _getKey(keyCode);
				switch(key) {
					case "up":
						this.selectPrev();
						break;
					case "down":
						this.selectNext();
						break;
					case "enter":
						var current = this.getCurrentSelectedResult();
						this.select(this.currentResults[current]);
						break;
					case "esc":
						this.clear();
						break;
				}
			}
		},

		selectPrev: function() {
			var current = this.getCurrentSelectedResult();
			if (current != 0) {
				this.setResultState(current, "");
				this.setResultState((current - 1), "selected");
			}
		},

		selectNext: function() {
			var current = this.getCurrentSelectedResult();
			if (current != this.currentResults.length -1) {
				this.setResultState(current, "");
				this.setResultState((current + 1), "selected");
			}
		},

		setResultState: function(index, state) {
			if (state == "selected") {
				_getByCl(this.currentResults[index].node, "slds-listbox__option").classList.add("slds-has-focus");
				this.currentResults[index].selected = true;
			} else {
				_getByCl(this.currentResults[index].node, "slds-listbox__option").classList.remove("slds-has-focus");
				this.currentResults[index].selected = false;
			}
		},

		getCurrentSelectedResult: function() {
			for (var i = 0; i < this.currentResults.length; i++) {
				if (this.currentResults[i].selected)
					return i;
			}
		},

		click: function(e) {
			var el = _findUp(e.target, "slds-listbox__item"); // Click event could fire on child
			if (el) {
				result = this.getMatchingResultByNode(el);
				this.select(result);
			}
		},

		getMatchingResultByNode: function(node) {
			for (var i = 0; i < this.currentResults.length; i++) {
				if (node.isSameNode(this.currentResults[i].node)) return this.currentResults[i];
			}
		},

		getResultIndexByNode: function(node) {
			for (var i = 0; i < this.currentResults.length; i++) {
				if (node.isSameNode(this.currentResults[i].node)) return i;
			}
		},

		select: function(result) {
			// Optional callback if provided to the constructor
			if (this.callback)
				this.callback({
					"source" : this.el,
					"result" : result.obj
				});
			else
				this.fillLine(result);
				_getByCl(_findUp(this.el, "cbds-detail-line"), "cbds-product-qty").focus();

			this.clear(); // Clear autocomplete
		},

		fillLine: function(result) {
			var lineNode = _findUp(result.node, "cbds-detail-line");

			_getByCl(lineNode, "cbds-product-line-image").src = result.obj.meta.image;

			_getByCl(lineNode, "cbds-product-line-unitcost").value = result.obj.pricing.unit_cost;
			_getByCl(lineNode, "cbds-product-line-listprice").value = result.obj.pricing.list_price;

			_getByCl(lineNode, "cbds-product-line-qtyinstock").value = result.obj.logistics.qty_in_stock;
			_getByCl(lineNode, "cbds-product-line-currordered").value = result.obj.logistics.curr_ordered;

			_getByCl(lineNode, "cbds-product-line-comments").innerHTML = result.obj.meta.comments;
			this.input.value = result.obj.meta.name;
		}
	}

	/**
	  * Section with factory tools
	  */
	function _on(el,type,func,context) {
		el.addEventListener(type, func.bind(context));
	}

	function _off(el,type,func,context) {
		el.removeEventListener(type, func.bind(context));
	}

	function _createEl(elType, className, inner) {
		var el = document.createElement(elType);

		if (className.indexOf(" ") == -1 && className != undefined && className != "") {
			el.classList.add(className);
		} else {
			var classes = className.split(" ");
			for (var i = 0; i < classes.length; i++) {
				if (classes[i] != "") el.classList.add(classes[i]);
			}
		}

		if (inner != undefined) el.innerHTML = inner;
		return el;
	}

	function _findUp(el, className) {
		if (el.classList.contains(className)) {
			return el;
		} else {
			while (el = el.parentElement) {
				if (el.classList.contains(className)) {
					return el;
					break;
				} else if (el === document.body) {
					return false;
				}
			}
		}
	}

	function _getByCl(root, className) {
		return root.getElementsByClassName(className)[0] != undefined ? root.getElementsByClassName(className)[0] : {};
	}

	function _getKey(code) {
		return window.keycodeMap[code];
	}

	/*
	 * Globals
	 */
	window.keycodeMap = {
			38: "up",
			40: "down",
			37: "left",
			39: "right",
			27: "esc",
			9:  "tab",
			13: "enter"
		}
	
	/*
	 * Export
	 */
	return ProductAutocomplete;
});