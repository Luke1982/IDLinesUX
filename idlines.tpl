<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>InventoryDetail lines mockup</title>
	<link rel="stylesheet" type="text/css" href="lib/LDS/styles/salesforce-lightning-design-system.css">
	<link rel="stylesheet" type="text/css" href="style.css">
	<script type="text/javascript" src="script.js"></script>
	<script type="text/javascript" src="Sortable.min.js"></script>
	<script type="text/javascript" src="InventoryLine.js"></script>
	<script type="text/javascript" src="InventoryField.js"></script>
	<script type="text/javascript" src="InventoryBlock.js"></script>
	<script type="text/javascript" src="ProductAutocomplete.js"></script>
	<script type="text/javascript" src="ldsCombobox.js"></script>
	<script type="text/javascript" src="ldsCheckbox.js"></script>
	<script type="text/javascript" src="cbNumber.js"></script>
</head>
<body>
	{include file='./templates/Components.tpl'}
	<div id="testcontainer">
		<!-- Detail block -->
		<div class="cbds-detail-block cbds-inventory-block">
			<!-- Detail line preheader -->
			<div class="slds-grid slds-p-vertical_medium cbds-detail-line-preheader">
				<div class="slds-col slds-size_8-of-12 slds-p-left_medium">
					<span class="slds-icon_container slds-icon-utility-shopping_bag" title="Add products or services">
						<svg class="slds-icon slds-icon-text-default slds-icon slds-icon-text-light" aria-hidden="true">
							<use xlink:href="lib/LDS/icons/utility-sprite/svg/symbols.svg#shopping_bag" xmlns:xlink="http://www.w3.org/1999/xlink" />
						</svg>
						<span class="slds-assistive-text">Description of icon when needed</span>
					</span>						
				</div>
				<div class="slds-col slds-size_2-of-12 slds-p-right_medium">
					<!-- Group/individual dropdown -->
					{$taxtypes[] = ['val' => 'individual', 'label' => 'Individual']}
					{$taxtypes[] = ['val' => 'group', 'label' => 'Group']}
					{if $inventoryblock.taxtype == 'group'}{$curtaxtype = 'Group'}{else}{$curtaxtype = 'Individual'}{/if}
					{call name=ProductDropdownFormElement size='1-of-1' fieldname='taxtype' value=$curtaxtype placeholder='Tax type' options=$taxtypes prefix='cbds-inventory-block__input'}
					<!-- // Group/individual dropdown -->
				</div>
				<div class="slds-col slds-size_1-of-12">
					<div class="slds-button-group">
						<button class="slds-button slds-button_icon slds-button_icon-border-inverse cbds-toolbox__tool" data-clickfunction="expandAllLines" title="Expand all lines" aria-pressed="false">
							<svg class="slds-button__icon" aria-hidden="true">
								<use xlink:href="lib/LDS/icons/utility-sprite/svg/symbols.svg#expand_all"></use>
							</svg>
							<span class="slds-assistive-text">Expand or collapse this line</span>
						</button>
						<button class="slds-button slds-button_icon slds-button_icon-border-inverse cbds-toolbox__tool" data-clickfunction="collAllLines" title="Collapse all lines" aria-pressed="false">
							<svg class="slds-button__icon" aria-hidden="true">
								<use xlink:href="lib/LDS/icons/utility-sprite/svg/symbols.svg#collapse_all"></use>
							</svg>
							<span class="slds-assistive-text">Expand or collapse this line</span>
						</button>
						<button class="slds-button slds-button_icon slds-button_icon-border-inverse cbds-toolbox__tool" data-clickfunction="insertNewLine" title="Add line" aria-pressed="false">
							<svg class="slds-button__icon" aria-hidden="true">
								<use xlink:href="lib/LDS/icons/utility-sprite/svg/symbols.svg#add"></use>
							</svg>
							<span class="slds-assistive-text">Expand or collapse this line</span>
						</button>
						<button class="slds-button slds-button_icon slds-button_icon-border-inverse cbds-toolbox__tool" data-clickfunction="deleteAllLines" title="Delete all lines" aria-pressed="false">
							<svg class="slds-button__icon" aria-hidden="true">
								<use xlink:href="lib/LDS/icons/utility-sprite/svg/symbols.svg#delete"></use>
							</svg>
							<span class="slds-assistive-text">Expand or collapse this line</span>
						</button>
					</div>
				</div>
				<div class="slds-col slds-size_1-of-12"></div>
			</div>
			<!-- // Detail line preheader -->
			<!-- LDS Detail line header -->
			<div class="slds-grid slds-border_bottom slds-p-vertical_small cbds-detail-line-header">
				<div class="slds-col slds-size_1-of-12 slds-p-left_x-small">
					<div class="slds-text-title_caps slds-text-color_inverse">Image</div>
				</div>
				<div class="slds-col slds-size-9-of-12">
					<div class="slds-grid">
						<div class="slds-col slds-size_3-of-12">
							<div class="slds-text-title_caps slds-text-color_inverse">Product name</div>
						</div>
						<div class="slds-col slds-size_1-of-12 slds-p-left_xx-small">
							<div class="slds-text-title_caps slds-text-color_inverse">Quantity</div>
						</div>
						<div class="slds-grid slds-size_3-of-12 slds-p-left_medium">
							<div class="slds-col slds-size_5-of-12">
								<div class="slds-text-title_caps slds-text-color_inverse">Discount type</div>
							</div>
							<div class="slds-col slds-size_6-of-12 slds-p-left_small">
								<div class="slds-text-title_caps slds-text-color_inverse">Discount</div>
							</div>
						</div>
						<div class="slds-col slds-size_2-of-12 slds-p-left_large">
							<div class="slds-text-title_caps slds-text-color_inverse">Discount amount</div>
						</div>
						<div class="slds-col slds-size_2-of-12 slds-p-left_x-large">
							<div class="slds-text-title_caps slds-text-color_inverse">Line total</div>
						</div>
					</div>
				</div>
				<div class="slds-col slds-size_2-of-12">
					<div class="slds-text-title_caps slds-p-left_large slds-text-color_inverse">Line tools</div>
				</div>
			</div>
			<!-- // LDS Detail line header -->
			<div class="cbds-detail-lines cbds-inventorylines">
				{foreach from=$inventoryblock.lines item=productline}
					{call name=InventoryLine data=$productline}
				{/foreach}
			</div>
			<style>{strip}
				{for $foo=1 to 100}
				.cbds-inventoryline:nth-child({$foo}) {ldelim}
					z-index: {100-$foo};
				{rdelim}
				{/for}{/strip}
			</style>
			<!-- LDS Aggregations block -->
			<article class="slds-card">
				<div class="slds-card__header slds-grid">
					<header class="slds-media slds-media_center slds-has-flexi-truncate">
						<div class="slds-media__figure">
							<span class="slds-icon_container slds-icon-standard-contact" title="description of icon when needed">
								<svg class="slds-icon slds-icon_small" aria-hidden="true">
									<use xlink:href="lib/LDS/icons/standard-sprite/svg/symbols.svg#product_required" xmlns:xlink="http://www.w3.org/1999/xlink" />
								</svg>
							</span>
						</div>
						<div class="slds-media__body">
							<h2>
								<a href="javascript:void(0);" class="slds-card__header-link slds-truncate" title="Total number of lines">
									<span class="slds-text-heading_small">Lines (<span class="cbds-inventoryaggr--linecount">{count($inventoryblock.lines)}</span>)</span>
								</a>
							</h2>
						</div>
					</header>
					<div class="slds-no-flex">
						<div class="slds-button-group">
							<button class="slds-button slds-button_icon slds-button_icon-border cbds-toolbox__tool" data-clickfunction="expandAllLines" title="Expand all lines" aria-pressed="false">
								<svg class="slds-button__icon" aria-hidden="true">
									<use xlink:href="lib/LDS/icons/utility-sprite/svg/symbols.svg#expand_all"></use>
								</svg>
								<span class="slds-assistive-text">Expand all lines</span>
							</button>
							<button class="slds-button slds-button_icon slds-button_icon-border cbds-toolbox__tool" data-clickfunction="collAllLines" title="Collapse all lines" aria-pressed="false">
								<svg class="slds-button__icon" aria-hidden="true">
									<use xlink:href="lib/LDS/icons/utility-sprite/svg/symbols.svg#collapse_all"></use>
								</svg>
								<span class="slds-assistive-text">Collapse all lines</span>
							</button>
							<button class="slds-button slds-button_icon slds-button_icon-border cbds-toolbox__tool" data-clickfunction="insertNewLine" title="Add line" aria-pressed="false">
								<svg class="slds-button__icon" aria-hidden="true">
									<use xlink:href="lib/LDS/icons/utility-sprite/svg/symbols.svg#add"></use>
								</svg>
								<span class="slds-assistive-text">Insert a new line</span>
							</button>
							<button class="slds-button slds-button_icon slds-button_icon-border cbds-button--delete cbds-toolbox__tool" data-clickfunction="deleteAllLines" title="Delete all lines" aria-pressed="false">
								<svg class="slds-button__icon" aria-hidden="true">
									<use xlink:href="lib/LDS/icons/utility-sprite/svg/symbols.svg#delete"></use>
								</svg>
								<span class="slds-assistive-text">Delete all lines</span>
							</button>
						</div>
					</div>
				</div>
				<div class="slds-card__body cbds-inventoryaggr">
					<ul class="slds-card__body_inner slds-grid slds-wrap slds-grid_pull-padded">
						<li class="slds-p-horizontal_small slds-size_1-of-1 slds-medium-size_1-of-5">
							<article class="slds-tile slds-tile_board">
								<h3 class="slds-tile__title slds-truncate slds-text-heading_small" title="Gross total">Gross total</h3>
								<div class="slds-tile__detail">
									<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
										<input type="text" readonly="readonly" data-type="currency" class="slds-input cbds-inventoryaggr__input--grosstotal" value="{$inventoryblock.aggr.grosstotal}" />
										<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_left">
											<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
												<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#euro" xmlns:xlink="http://www.w3.org/1999/xlink" />
											</svg>
										</span>
									</div>
								</div>
							</article>
						</li>
						<li class="slds-p-horizontal_small slds-size_1-of-1 slds-medium-size_1-of-5">
							<article class="slds-tile slds-tile_board">
								<h3 class="slds-tile__title slds-truncate slds-text-heading_small" title="Total discount">Total discount</h3>
								<div class="slds-tile__detail">
									<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
										<input type="text" readonly="readonly" data-type="currency" class="slds-input cbds-inventoryaggr__input--totaldiscount" value="{$inventoryblock.aggr.totaldiscount}" />
										<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_left">
											<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
												<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#euro" xmlns:xlink="http://www.w3.org/1999/xlink" />
											</svg>
										</span>
									</div>
								</div>
							</article>
						</li>
						<li class="slds-p-horizontal_small slds-size_1-of-1 slds-medium-size_1-of-5">
							<article class="slds-tile slds-tile_board">
								<h3 class="slds-tile__title slds-truncate slds-text-heading_small" title="Total taxes">Total taxes</h3>
								<div class="slds-tile__detail">
									<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
										<input type="text" readonly="readonly" data-type="currency" class="slds-input cbds-inventoryaggr__input--taxtotal" value="{$inventoryblock.aggr.taxtotal}" />
										<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_left">
											<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
												<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#euro" xmlns:xlink="http://www.w3.org/1999/xlink" />
											</svg>
										</span>
									</div>
								</div>
							</article>
						</li>
						<li class="slds-p-horizontal_small slds-size_1-of-1 slds-medium-size_1-of-5">
							<article class="slds-tile slds-tile_board">
								<h3 class="slds-tile__title slds-truncate slds-text-heading_small" title="Net total">Net total</h3>
								<div class="slds-tile__detail">
									<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
										<input type="text" readonly="readonly" data-type="currency" class="slds-input cbds-inventoryaggr__input--subtotal" value="{$inventoryblock.aggr.subtotal}" />
										<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_left">
											<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
												<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#euro" xmlns:xlink="http://www.w3.org/1999/xlink" />
											</svg>
										</span>
									</div>
								</div>
							</article>
						</li>
						<li class="slds-p-horizontal_small slds-size_1-of-1 slds-medium-size_1-of-5">
							<article class="slds-tile slds-tile_board">
								<h3 class="slds-tile__title slds-truncate slds-text-heading_small" title="Total">Total</h3>
								<div class="slds-tile__detail">
									<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
										<input type="text" readonly="readonly" data-type="currency" class="slds-input cbds-inventoryaggr__input--total" value="{$inventoryblock.aggr.total}" />
										<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_left">
											<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
												<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#euro" xmlns:xlink="http://www.w3.org/1999/xlink" />
											</svg>
										</span>
									</div>
								</div>
							</article>
						</li>
					</ul>
					<!-- Aggregation tax block -->
					<div class="cbds-inventoryaggr__taxes">
						<!-- Group aggregation taxes -->
						<div class="slds-form slds-form_compound slds-p-around_medium cbds-inventoryaggr__taxes--group{if $inventoryblock.taxtype == 'group'} active{/if}">
							<div class="slds-form-element__row">
								<div class="slds-text-heading_medium">Group Taxes</div>
							</div>
							<div class="slds-form-element__row slds-wrap">
								{foreach from=$inventoryblock.grouptaxes item=tax key=key name=name}
								<div class="slds-form-element__group slds-size_1-of-4">
									<fieldset class="slds-form-element">
										<legend class="slds-form-element__label slds-text-title_caps">{$tax.taxname}</legend>
										<div class="slds-grid">
										<div class="slds-col slds-form-element slds-size_5-of-12">
											<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
												<input class="slds-input cbds-inventoryaggr__input--tax{$key}" value="{$tax.percent}" type="text" data-type="number" data-taxname="tax{$key}" data-error-mess="Please insert a valid number">
												<span class="slds-icon_container slds-icon-corebos-percent slds-input__icon slds-input__icon_left">
													<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
														<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#percent" xmlns:xlink="http://www.w3.org/1999/xlink"></use>
													</svg>
												</span>
											</div>
											<div class="slds-form-element__help"></div>
										</div>
										<div class="slds-col slds-form-element slds-size_7-of-12">
											<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
												<input class="slds-input cbds-inventoryaggr__input--tax{$key}-amount" data-type="currency" readonly="readonly" value="{$tax.amount}" type="text">
												<span class="slds-icon_container slds-icon-corebos-euro slds-input__icon slds-input__icon_left">
													<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
														<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#euro" xmlns:xlink="http://www.w3.org/1999/xlink"></use>
													</svg>
												</span>
											</div>
										</div>
									</fieldset>
								</div>
								{/foreach}
							</div>
						</div>
						<!-- // Group aggregation taxes -->
						<!-- Shipping and handling aggregation taxes -->
						<div class="slds-form slds-form_compound slds-p-around_medium cbds-inventoryaggr__taxes--sh">
							<div class="slds-form-element__row">
								<div class="slds-text-heading_medium">Sales and Handling Taxes</div>
							</div>
							<div class="slds-form-element__row slds-wrap">
								{foreach from=$inventoryblock.shtaxes item=shtax key=key name=name}
								<div class="slds-form-element__group slds-size_1-of-4">
									<fieldset class="slds-form-element">
										<legend class="slds-form-element__label slds-text-title_caps">{$shtax.taxname}</legend>
										<div class="slds-grid">
										<div class="slds-col slds-form-element slds-size_5-of-12">
											<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
												<input class="slds-input cbds-inventoryaggr__input--shtax{$key}" value="{$shtax.percent}" type="text" data-type="number" data-taxname="shtax{$key}" data-error-mess="Please insert a valid number">
												<span class="slds-icon_container slds-icon-corebos-percent slds-input__icon slds-input__icon_left">
													<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
														<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#percent" xmlns:xlink="http://www.w3.org/1999/xlink"></use>
													</svg>
												</span>
											</div>
											<div class="slds-form-element__help"></div>
										</div>
										<div class="slds-col slds-form-element slds-size_7-of-12">
											<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
												<input class="slds-input cbds-inventoryaggr__input--shtax{$key}-amount" data-type="currency" readonly="readonly" value="{$shtax.amount}" type="text">
												<span class="slds-icon_container slds-icon-corebos-euro slds-input__icon slds-input__icon_left">
													<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
														<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#euro" xmlns:xlink="http://www.w3.org/1999/xlink"></use>
													</svg>
												</span>
											</div>
										</div>
									</fieldset>
								</div>
								{/foreach}
							</div>
						</div>
						<!-- // Shipping and handling aggregation taxes -->
					</div>
					<!-- // Aggregation tax block -->
				</div>
			</article>
			<!-- // LDS Aggregations block -->
		</div>
		<!-- Detail block -->
		<!-- Template -->
		{$custom = $inventoryblock.lines[0].custom}
		{call name=InventoryLine template=true custom=$custom}
		<!-- // Template -->
	</div>
</body>
</html>