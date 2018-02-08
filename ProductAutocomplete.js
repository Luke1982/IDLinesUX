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
	 */
	function ProductAutocomplete(el){
		this.el = el,
		this.specialKeys = ["up","down","esc"],
		this.threshold = 3,
		this.input = el.getElementsByTagName("input")[0],
		this.source = "sample-products.json",
		this.active = false,
		this.resultContainer,
		this.currentResults = [];

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
			if (!this.active)
				this.resultContainer = this.buildResultContainer();
				this.attachResultContainer(this.resultContainer);
				this.active = true;

			// Build results
			var results = this.buildResults(res);
		},

		buildResultContainer: function() {
			var ul = document.createElement("ul");
			ul.classList.add("cbds-product-search__results");
			return ul;
		},

		attachResultContainer: function(containerUl) {
			this.el.appendChild(containerUl);
		},

		buildResults: function(results) {
			this.resultContainer.innerHTML = "";
			for (var i = 0; i < results.length; i++) {
				this.attachResultToContainer(this.buildResult(results[i]));
			}
		},

		buildResult: function(result) {
			var li = _createEl("li", "cbds-product-result");
			var title = _createEl("div", "cbds-product-result__title", result.meta.name);
			
			li.appendChild(title);
			li.appendChild(this.buildResultLine("Manufacturer No.", result.meta.mfr_no));
			li.appendChild(this.buildResultLine("Vendor No.", result.meta.ven_no));

			this.currentResults.push({
				"obj" 	: result,
				"node"	: li
			});

			_on(li, "click", this.click, this);

			return li;
		},

		buildResultLine: function(label, value) {
			var label = _createEl("span", "cbds-product-result-line__label", label);
			var value = _createEl("span", "cbds-product-result-line__value", value);
			var line = _createEl("div", "cbds-product-result-line");
			line.appendChild(label);
			line.appendChild(value);
			return line;
		},

		attachResultToContainer: function (resultLi) {
			this.resultContainer.appendChild(resultLi);
		},

		clear: function() {
			if (this.active)
				this.resultContainer.parentElement.removeChild(this.resultContainer);
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
			}
		},

		click: function(e) {
			var el = _findUp(e.target, "cbds-product-result"); // Click event could fire on child
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

		select: function(result) {
			var lineNode = _findUp(result.node, "cbds-detail-line");
			_getByCl(lineNode, "cbds-product-line-image").src = result.obj.meta.image;
			this.input.value = result.obj.meta.name;
			this.clear();
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
		el.classList.add(className);
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
		return root.getElementsByClassName(className)[0];
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
			9:  "tab"
		}
	
	/*
	 * Export
	 */
	return ProductAutocomplete;
});