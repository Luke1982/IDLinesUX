/****
	* cbNumber
	* @author: MajorLabel <info@majorlabel.nl>
	* @license GNU
	*/
(function cbnumberModule(factory){

	if (typeof define === "function" && define.amd) {
		define(factory);
	} else if (typeof module != "undefined" && typeof module.exports != "undefined") {
		module.exports = factory();
	} else {
		window["cbNumber"] = factory();
	}

})(function cbnumberFactory(){

	/**
	 * @class ldsCheckbox
	 */
	function cbNumber() {
		/* Public attributes */
	}

	/*
	 * Static properties
	 */
	cbNumber.decSep = window.userDecimalSeparator,
	cbNumber.curSep = window.userCurrencySeparator,
	cbNumber.decNum = Number(window.userNumberOfDecimals);

	/*
	 * Static methods
	 */

	/*
	 * curToNumString
	 *--------------------------
	 * Turns a currency formatted string into a number formatted
	 * string. Respects the currently selected user format
	 *
	 * @return: Number formatted string
	 */
	cbNumber.curToNumString = function(cur) {
		var c = cur.toString(),
			curR = new RegExp("\\"+this.curSep, "g"),
			decR = new RegExp("(\\"+this.decSep+")([0-9]{2})", "g"),
			c = c.replace(curR, "").replace(decR, ".$2");
		return parseFloat(c).toFixed(this.decNum).toString();
	}

	/*
	 * curToNum
	 *--------------------------
	 * Turns a currency formatted string into a number.
	 * Respects the currently selected user format
	 *
	 * @return: Number
	 */
	cbNumber.curToNum = function(cur) {
		return parseFloat(cbNumber.curToNumString(cur));
	}

	/*
	 * isCur
	 *--------------------------
	 * Tests if a string is formatted to the current
	 * user's currency settings. Respects the fact that
	 * decimals are optional
	 *
	 * @return: Bool
	 */
	cbNumber.isCur = function(cur) {
		var r = new RegExp("^\\d{1,3}(\\" + this.curSep + "\\d{3})*(\\" + this.decSep + "\\d{" + this.decNum + "})?$", "");
		return (cur.match(r) || []).length == 0 ? false : true;
	}

	/*
	 * numToCurr
	 *--------------------------
	 * Turns a number into a currencu formatted string.
	 * Respects the user settings, but does NOT add decimals
	 * if the number is an integer
	 *
	 * @return: Currency formatted string
	 */
	cbNumber.numToCurr = function(n){
		var n = n, 
			c = cbNumber.decimalNum(n) == 0 ? 0 : 2, 
			d = this.decSep == undefined ? "." : this.decSep, 
			t = this.curSep == undefined ? "," : this.curSep, 
			s = n < 0 ? "-" : "", 
			i = String(parseInt(n = Math.abs(Number(n) || 0).toFixed(c))), 
			j = (j = i.length) > 3 ? j % 3 : 0;
			return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
	}

	/*
	 * decimalNum
	 *--------------------------
	 * Takes a number (or string formatted as a number)
	 * and returns the number of decimals it has
	 *
	 */	
	cbNumber.decimalNum = function(num) {
		var match = (''+num).match(/(?:\.(\d+))?(?:[eE]([+-]?\d+))?$/);
		if (!match) { return 0; }
		return Math.max(0, (match[1] ? match[1].length : 0) - (match[2] ? +match[2] : 0));
	}

	cbNumber.prototype = {
		constructor: cbNumber,
	}

	/*
	 * Export
	 */
	return cbNumber;

});