/****
	* InventoryLine
	* @author: MajorLabel <info@majorlabel.nl>
	* @license GNU
	*/
(function inventorylineModule(factory){

	if (typeof define === "function" && define.amd) {
		define(factory);
	} else if (typeof module != "undefined" && typeof module.exports != "undefined") {
		module.exports = factory();
	} else {
		window["InventoryLine"] = factory();
	}

})(function inventorylineFactory(){

	/**
	 * @class InventoryLine
	 * @param {element}
	 * @param {root} : InventoryBlock instance that is parent
	 */
	function InventoryLine(el, rootObj){
		/* Public properties */
		this.el 		= el,
		this.root		= rootObj,
		this.u 			= rootObj.utils,
		this.extraLine	= this.u.getFirstClass(el, this.root.lineClass + "__extra"),
		this.extraTool 	= _getTool(el, "extra"),
		this.comboBoxes	= [],
		this.discCombo 	= {},
		this.fields 	= {};

		/* Private properties */
		var copyTool 	= _getTool(el, "copy"),
			delTool 	= _getTool(el, "delete"),
			comboBoxes	= el.getElementsByClassName("slds-combobox-picklist"),
			inputs 		= el.getElementsByTagName("input"),
			_this 		= this;

		/* Instance Constructor */
		var construct 	= function(me) {
			me.id = me.root.inventoryLines.seq + 1,
			me.root.inventoryLines.seq++,
			me.root.inventoryLines[me.id] = me;

			new ProductAutocomplete(me.u.getFirstClass(me.el, "cbds-product-search"), me, rootObj);

			for (var i = 0; i < comboBoxes.length; i++) {
				var isDiscountBox = comboBoxes[i].getElementsByTagName("input")[0].classList.contains("cbds-inventoryline__input--discount_type"),
					comboBox = new ldsCombobox(comboBoxes[i], {
					"onSelect" : isDiscountBox ? me.setDiscType.bind(me) : null
				});
				if (isDiscountBox) me.discCombo = comboBox;
				me.comboBoxes.push(comboBox);
			}

			for (var i = 0; i < inputs.length; i++) {
				var field = new InventoryField(inputs[i], rootObj, {
					"decimals" : 2,
					"decSep" : window.userDecimalSeparator,
					"curSep" : window.userCurrencySeparator
				});
				me.fields[field.getFieldName()] = field;
			}
			
			ldsCheckbox.setUnique();
		}
		construct(this);

		/* Instance listeners */
		this.u.on(copyTool, "click", this.copy, this);
		this.u.on(delTool, "click", this.delete, this);
		this.u.on(this.extraTool, "click", this.toggleExtra, this);
		this.u.on(el, "keyup", this.handleInput, this);
	}

	InventoryLine.prototype = {
		constructor	: InventoryLine,

		copy 		: function(){
						var original = this.el,
							newNode = original.cloneNode(true);

						this.u.insertAfter(original, newNode);
						new InventoryLine(newNode, this.root);
						this.root.updateCount();
						this.root.updateAggr();
					},

		delete 		: function() {
						this.el.parentNode.removeChild(this.el);
						this.u.off(this.extraTool, "click", this.toggleExtra);
						delete this.root.inventoryLines[this.id];

						this.el = null;
						this.root.updateCount();
						this.root.updateAggr();
					},

		toggleExtra : function() {
						this.extraLine.classList.toggle(this.root.lineClass + "__extra--expanded");
						this.extraTool.children[0].classList.toggle("cbds-exp-coll-icon--expanded");
					},

		expandExtra : function() {
						this.extraLine.classList.add(this.root.lineClass + "__extra--expanded");
						this.extraTool.children[0].classList.add("cbds-exp-coll-icon--expanded");
					},

		collExtra 	: function() {
						this.extraLine.classList.remove(this.root.lineClass + "__extra--expanded");
						this.extraTool.children[0].classList.remove("cbds-exp-coll-icon--expanded");
					},
		handleInput	: function(e) {
						var input = this.getInputObj(e.target);
						input.format(e);
						var validated = input.validate();

						if (!validated)
							input.setState("error");
						else
							this.calcLine();
		},
		getInputObj : function(node) {
						for (field in this.fields) {
							if (this.fields[field].el.isSameNode(node)) {
								return this.fields[field];
							}
						}
		},
		getDiscType: function(){
						return this.discCombo.getVal();
		},
		setDiscType: function() {
						var use = this.u.getFirstClass(this.el, "cbds-inventoryline__symbol--discount_amount").getElementsByTagName("use")[0],
							symbol = use.getAttribute("xlink:href").split("#"),
							newType = this.getDiscType();

						if (newType == "p")
							use.setAttribute("xlink:href", symbol[0] + "#percent");
						else
							use.setAttribute("xlink:href", symbol[0] + "#euro");

						this.calcLine();
		},
		calcLine 	: function() {
						var validated = this.validate();

						if (validated)
							this.calcCostPrice();
							this.calcLineGross();
							this.calcDiscount();
							this.calcLineNet();
							this.setField("linetotal", Number(this.fields.extnet.getValue()) + this.calcLineTax());
							this.root.updateAggr();
		},
		validate 	: function() {
						var validated = true;
						for (field in this.fields) {
							if (!this.fields[field].validate()) {
								validated = false;
								this.fields[field].setState("error");
							} else {
								this.fields[field].setState("normal");
							}
						}
						return validated;
		},
		calcCostPrice: function() {
						this.setField("cost_gross", this.fields.cost_price.getValue() * this.fields.quantity.getValue());
		},
		calcLineGross: function() {
						this.setField("extgross", this.fields.quantity.getValue() * this.fields.unit_price.getValue());
		},
		calcDiscount: function() {
						var type = this.getDiscType(),
						 	gross = this.fields.extgross.getValue(),
						 	disc = this.fields.discount_amount.getValue(),
						 	amount = type == "p" ? _getPerc(gross, disc) : disc;

						this.setField("discount_total", amount);
		},
		calcLineNet: function() {
						var gross = this.fields.extgross.getValue(),
							disc = this.fields.discount_total.getValue();

						this.setField("extnet", (gross - disc));
		},
		calcLineTax: function() {
						var totalTax = 0;
						for (var i = 0; i < this.noOfLineTaxes(); i++) {
							totalTax = totalTax + this.calcIndivTax(i+1);
						}
						return Number(totalTax.toFixed(2));
		},
		calcIndivTax: function(i) {
						var taxFieldName = "tax" + i,
							taxPercent = this.fields[taxFieldName].getValue(),
							lineNet = this.fields.extnet.getValue(),
							taxAmount = _getPerc(lineNet, taxPercent);

						this.setField("tax" + i + "-amount", taxAmount);
						return taxAmount;
		},
		noOfLineTaxes : function() {
						var no = 0;
						for (field in this.fields) {
							if (field.match(/["tax"][0-9]{1,2}$/))
								no++;
						}
						return no;
		},
		setField 	: function(fieldname, newVal) {
						this.fields[fieldname].el.value = newVal;
						this.fireJsInput(fieldname);
		},
		fireJsInput	: function(fieldname) {
						var evt = new CustomEvent("jsInput");
						this.fields[fieldname].el.dispatchEvent(evt);
		}
	}

	/**
	  * Section with factory tools
	  */

	function _getTool(root, sort) {
		var tool = root.getElementsByClassName("cbds-detail-line-" + sort + "tool")[0];
		return tool === undefined ? document.createElement("div") : tool;
	}

	function _deductPerc(base, percentage) {
		return (base * (1 - (percentage / 100)));
	}

	function _getPerc(base, percentage) {
		return base * (percentage / 100);
	}

	// ONLY FOR DEVELOPMENT, REMOVE WHEN USED IN COREBOS
	window.userDecimalSeparator = ",";
	window.userCurrencySeparator = ".";
	window.userNumberOfDecimals = "2";

	/*
	 * Export
	 */
	return InventoryLine;

});