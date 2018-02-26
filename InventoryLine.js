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
		this.extraLine	= this.root.utils.getFirstClass(el, this.root.lineClass + "__extra"),
		this.extraTool 	= _getTool(el, "extra"),
		this.comboBoxes	= [],
		this.inputs		= [],
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

			new ProductAutocomplete(me.root.utils.getFirstClass(me.el, "cbds-product-search"), me, rootObj);

			for (var i = 0; i < comboBoxes.length; i++) {
				me.comboBoxes.push(new ldsCombobox(comboBoxes[i], {
					"onSelect" : comboBoxes[i].getElementsByTagName("input")[0].classList.contains("cbds-inventoryline__input--discount_type") ? me.setDiscType.bind(me) : null
				}));
			}

			for (var i = 0; i < inputs.length; i++) {
				me.inputs.push(new InventoryField(inputs[i], rootObj, {
					"decimals" : 2,
					"decSep" : window.userDecimalSeparator,
					"curSep" : window.userCurrencySeparator
				}));
			}

			me.getFields();
		}
		construct(this);

		/* Instance listeners */
		this.root.utils.on(copyTool, "click", this.copy, this);
		this.root.utils.on(delTool, "click", this.delete, this);
		this.root.utils.on(this.extraTool, "click", this.toggleExtra, this);
		this.root.utils.on(el, "keyup", this.handleInput, this);
	}

	InventoryLine.prototype = {
		constructor	: InventoryLine,

		copy 		: function(){
						var original = this.el,
							newNode = original.cloneNode(true);

						this.root.utils.insertAfter(original, newNode);
						new InventoryLine(newNode, this.root);
					},

		delete 		: function() {
						this.el.parentNode.removeChild(this.el);
						this.root.utils.off(this.extraTool, "click", this.toggleExtra);
						delete this.root.inventoryLines[this.id];

						this.el = null;
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
						var input = this.getInputObj(e.target),
							validated = input.validate();

						if (!validated) {
							input.setState("error");
						} else {
							input.setState("normal");
							input.format(e);
						}

						this.calcLine();
		},
		getInputObj : function(node) {
						for (var i = 0; i < this.inputs.length; i++) {
							if (this.inputs[i].el.isSameNode(node)) {
								return this.inputs[i];
							}
						}
		},
		getDiscType: function(){
						return this.root.utils.getFirstClass(this.el, this.root.inputPrefix + "--discount_type").value;
		},
		setDiscType: function() {
						var use = this.root.utils.getFirstClass(this.el, "cbds-inventoryline__symbol--discount_amount").getElementsByTagName("use")[0],
							symbol = use.getAttribute("xlink:href").split("#"),
							newType = this.getDiscType();

						if (newType == "Percentage")
							use.setAttribute("xlink:href", symbol[0] + "#percent");
						else
							use.setAttribute("xlink:href", symbol[0] + "#euro");
		},
		getFields 	: function() {
						for (var i = 0; i < this.inputs.length; i++) {
							if (this.inputs[i].getFieldName() != undefined)
								this.fields[this.inputs[i].getFieldName()] = this.inputs[i].getValue(); 
						}
		},
		calcLine 	: function() {
						var validated = this.validate();
		},
		validate 	: function() {
						var validated = false;
						for (var i = 0; i < this.inputs.length; i++) {
							if (!this.inputs[i].validate()) {
								validated = false;
								break;
							} else {
								validated = true;
							}
						}
						return validated;
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

	// ONLY FOR DEVELOPMENT, REMOVE WHEN USED IN COREBOS
	window.userDecimalSeparator = ",";
	window.userCurrencySeparator = ".";

	/*
	 * Export
	 */
	return InventoryLine;

});