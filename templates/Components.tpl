{$productline_classprefix = 'cbds-inventoryline' scope=global}
{$productline_inputprefix = 'cbds-inventoryline__input' scope=global}

{* Define the product line component *}
{function name=InventoryLine template=false data=[]}
{* Set some defaults when this is a template call *}
{if $template}
	{$data.meta = []}
	{$data.meta.discount_type = 'p'}
	{$data.meta.discount_amount = 0}
	{$data.meta.extgross = 0}
	{$data.meta.extnet = 0}
	{$data.meta.linetotal = 0}
	{$data.meta.quantity = 0}
	{$data.meta.description = ''}

	{$data.pricing = []}
	{$data.pricing.cost_price = 0}
	{$data.pricing.cost_gross = 0}
	{$data.pricing.unit_price = 0}

	{$data.logistics = []}
	{$data.logistics.units_delivered_received = 0}
	{$data.logistics.qtyinstock = 0}
	{$data.logistics.qtyindemand = 0}

	{$data.taxes = []}
	
	{$data.taxes.1 = []}
	{$data.taxes.1.percent = 0}
	{$data.taxes.1.amount = 0}
	{$data.taxes.1.taxname = 'VAT'}
	{$data.taxes.2 = []}
	{$data.taxes.2.percent = 0}
	{$data.taxes.2.amount = 0}
	{$data.taxes.2.taxname = 'Sales tax'}
	{$data.taxes.3 = []}
	{$data.taxes.3.percent = 0}
	{$data.taxes.3.amount = 0}
	{$data.taxes.3.taxname = 'Service tax'}
{/if}
<!-- LDS Detail line for inventorydetails -->
<div class="{$productline_classprefix} slds-p-vertical_small{if $template} {$productline_classprefix}--template{/if}">
	<!-- Main LDS inventory details line -->
	<div class="slds-grid slds-gutters cbds-detail-line__main">
		<div class="slds-col slds-size_1-of-12">
			<div class="cbds-image-container cbds-image-container--small">
				<img src="{if !$template && isset($data.meta.image) && $data.meta.image != ''}{$data.meta.image}{/if}" class="cbds-image cbds-product-line-image" />
			</div>
		</div>
		<!-- Nested column with input fields -->
		<div class="slds-col slds-size_9-of-12 slds-align-middle">
			<fieldset class="slds-form slds-gutters slds-form_compound">
				<legend class="slds-assistive-text">Edit inventorydetails record</legend>
				<div class="slds-form-element__group">
					<div class="slds-form-element__row">
						<!-- Product name form element -->
						<div class="slds-form-element slds-size_2-of-8">
							<div class="slds-combobox_container slds-has-inline-listbox cbds-product-search">
								<div class="slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-combobox-lookup" aria-expanded="false" aria-haspopup="listbox" role="combobox">
									<div class="slds-combobox__form-element slds-input-has-icon slds-input-has-icon_right" role="none">
										<input class="slds-input slds-combobox__input {$productline_inputprefix}--name" aria-autocomplete="list" aria-controls="listbox-unique-id" autocomplete="off" role="textbox" placeholder="Search Products and services" type="text" value="{if !$template}{$data.meta.name}{/if}" />
										{call name=LDSIcon lib='utility' icon='search' align='right' size='x-small'}
									</div>
								</div>
							</div>
						</div>
						<!-- // Product name form element -->
						<!-- Product quantity form element -->
						{call name=ProductInputFormElement size='1-of-8' fieldname='quantity' value=$data.meta.quantity iconlib='corebos' icon='none' istemplate=$template type='number' error='Please input a number'}
						<!-- // Product quantity form element -->
						<!-- Discount type form element -->
						{if $data.meta.discount_type == 'p'}{$curval = 'Percentage'}{else}{$curval = 'Direct'}{/if}
						{$options = ['Direct', 'Percentage']}
						{call name=ProductDropdownFormElement size='1-of-8' fieldname='discount_type' value=$curval placeholder='Discount type' options=$options istemplate=$template}
						<!-- // Discount type form element -->
						<!-- Discount number (percent/direct) form element -->
						{call name=ProductInputFormElement size='1-of-8' fieldname='discount_amount' value=$data.meta.discount_amount iconlib='corebos' icon='percent' istemplate=$template type='number' error='Please input a numeric value into this field'}
						<!-- // Discount number (percent/direct) form element -->
						<!-- Discount amount form element -->
						{$discount_total = $data.meta.extgross - $data.meta.extnet}
						{call name=ProductInputFormElement size='1-of-8' fieldname='discount_total' value=$discount_total iconlib='corebos' icon='euro' istemplate=$template readonly=true}
						<!-- // Discount amount form element -->
						<!-- Line total form element -->
						{call name=ProductInputFormElement size='1-of-8' fieldname='linetotal' value=$data.meta.linetotal iconlib='corebos' icon='euro' istemplate=$template type='currency' readonly=true}
						<!-- // Line total form element -->
					</div>
				</div>
			</fieldset>
		</div>
		<!-- // Nested column with input fields -->
		<!-- LDS Line tools column -->
		<div class="slds-col slds-size_2-of-12 slds-align-middle">
			<div class="slds-button-group">
				{call name=LDSButton el='div' iconlib='utility' icon='move' iconsize='x-small' extraclass='cbds-detail-line-dragtool' title='Drag this line'}
				{call name=LDSButton el='button' iconlib='utility' icon='copy' iconsize='x-small' extraclass='cbds-detail-line-copytool' title='Copy this line'}
				{call name=LDSButton el='button' iconlib='utility' icon='delete' iconsize='x-small' extraclass='cbds-button--delete cbds-detail-line-deletetool' title='Delete this line'}
				{call name=LDSButton el='button' iconlib='utility' icon='switch' iconsize='x-small' extraclass='cbds-detail-line-extratool' title='Expand or collapse this line'}
			</div>
		</div>
		<!-- // LDS Line tools column -->
	</div>
	<!-- // Main LDS inventory details line -->
	<!-- Extra LDS inventory line -->
	<div class="slds-grid slds-gutters slds-p-vertical_medium {$productline_classprefix}__extra">
		<!-- LDS extra inventoryline column -->
		<div class="slds-col slds-size_1-of-4">
			<div class="slds-panel">
				<div class="cbds-panelheader">
					<div class="slds-text-color_inverse slds-align_absolute-center">Pricing</div>
				</div>
				<div class="slds-form slds-form_stacked slds-grow">
					{call name=ProductPanelSection fieldname='cost_price' label='Unit cost price' value=$data.pricing.cost_price symbol='euro' type='currency' error="Please enter a valid currency amount"}
					{call name=ProductPanelSection fieldname='cost_gross' label='Line cost price' value=$data.pricing.cost_gross symbol='euro'}
					{call name=ProductPanelSection fieldname='unit_price' label='Unit price' value=$data.pricing.unit_price symbol='euro' type='currency' error="Please enter a valid currency amount"}
				</div>
			</div>
		</div>
		<!-- // LDS extra inventoryline column -->
		<!-- LDS extra inventoryline column -->
		<div class="slds-col slds-size_1-of-4">
			<div class="slds-panel">
				<div class="cbds-panelheader">
					<div class="slds-text-color_inverse slds-align_absolute-center">Logistics</div>
				</div>
				<div class="slds-form slds-form_stacked slds-grow">
					{call name=ProductPanelSection fieldname='units_delivered_received' label='Units delivered / received' value=$data.logistics.units_delivered_received symbol='none'}
					{call name=ProductPanelSection fieldname='qtyinstock' label='Qty in stock' value=$data.logistics.qtyinstock symbol='none'}
					{call name=ProductPanelSection fieldname='qtyindemand' label='Currently ordered' value=$data.logistics.qtyindemand symbol='none'}
				</div>
			</div>
		</div>
		<!-- // LDS extra inventoryline column -->
		<!-- LDS extra inventoryline column -->
		<div class="slds-col slds-size_1-of-4">
			<div class="slds-panel">
				<div class="cbds-panelheader">
					<div class="slds-text-color_inverse slds-align_absolute-center">Taxes</div>
				</div>
				<div class="slds-form slds-form_compound slds-grow">
					{foreach from=$data.taxes item=tax key=key}
						{call name=ProductTaxPanelSection fieldname='tax'|cat:$key label=$tax.taxname amount=$tax.amount percent=$tax.percent symbol='euro'}
					{/foreach}
				</div>
			</div>
		</div>
		<!-- // LDS extra inventoryline column -->
		<!-- LDS extra inventoryline column -->
		<div class="slds-col slds-size_1-of-4">
			<div class="slds-panel">
				<div class="cbds-panelheader">
					<div class="slds-text-color_inverse slds-align_absolute-center">Comments</div>
				</div>
				<div class="slds-form slds-form_stacked slds-grow">
					<div class="slds-panel__section slds-border_bottom">
						<div class="slds-form-element">
							<div class="slds-form-element__control">
								<textarea rows="10" class="slds-textarea {$productline_classprefix}--comments" placeholder="Type a comment">{if $data.meta.description != ''}{$data.meta.description}{/if}</textarea>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- // LDS extra inventoryline column -->
	</div>
	<!-- // Extra LDS inventory line -->
</div>
<!-- // LDS Detail line for inventorydetails -->
{/function}


{*
 * Function: ProductPanelSection
 * ----------------------------------------------------------------------
 * Creates a panel section for the product panels in the extra
 * line.
 *
 * @param: The fieldname, should be the internal coreBOS fieldname
 * @param: The label, should be the field label
 * @param: The value, should be the current value of the field, if any
 * @param: The symbol. Should be the symbol. Current options are 'percent',
 * 			'euro', of 'none' (prevents symbol output)
*}
{function name=ProductPanelSection fieldname='' label='' value='' symbol='euro' type='' error=''}
<div class="slds-panel__section slds-border_bottom">
	<div class="slds-form-element">
		<label class="slds-form-element__label">{$label}</label>
		<div class="slds-form-element__control{if $symbol != 'none'} slds-input-has-icon slds-input-has-icon_left{/if}">
			<input type="text" class="slds-input {$productline_inputprefix}--{$fieldname}" value="{$value}" data-type="{$type}" data-error-mess="{$error}" />
			{if $symbol != 'none'}
				{call name=LDSIcon lib='corebos' icon=$symbol align='left' size='x-small'}
			{/if}
		</div>
		<div class="slds-form-element__help"></div>
	</div>
</div>
{/function}

{*
 * Function: ProductTaxPanelSection
 * ----------------------------------------------------------------------
 * Special function that outputs a custom panel section for the taxes,
 * these should have two fields, percentage and amount
 *
 * @param: The fieldname, should be the internal coreBOS fieldname
 * @param: The label, should be the field label
 * @param: The amount, should be the tax amount in the chosen currency
 * @param: The symbol, should be the currency symbol for the current user.
*}
{function name=ProductTaxPanelSection fieldname='' label='' amount='' percent='' symbol='euro'}
<div class="slds-panel__section slds-border_bottom">
	<span class="slds-form-element__label">{$label}</span>
	<div class="slds-form-element__row cbds-m-bottom_none">
		<div class="slds-form-element slds-size_5-of-12">
			<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
				<input type="text" class="slds-input" value="{$percent}" />
				{call name=LDSIcon lib='corebos' icon='percent' align='left' size='x-small'}
			</div>
		</div>
		<div class="slds-form-element slds-size_7-of-12">
			<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
				<input type="text" class="slds-input" readonly="readonly" value="{$amount}" />
				{call name=LDSIcon lib='corebos' icon=$symbol align='left' size='x-small'}
			</div>
		</div>
	</div>
</div>
{/function}

{*
 * Function: ProductInputFormElement
 * ----------------------------------------------------------------------
 * Outputs a form element, optionally with an icon (right now fixed to
 * the corebos library of icons)
 *
 * @param: The size of the form element, check LDS documentation
 * 			on: https://www.lightningdesignsystem.com/utilities/sizing
 * @param: The fieldname, should be the coreBOS fieldname
 * @param: The value, the value of the input field, if any
 * @param: The library for the icon, can be 'corebos' or one of the
 *         ones mentioned on https://www.lightningdesignsystem.com/icons
 * @param: The icon, should be the icon name from the corebos icon lib,
 * 			or 'none' (prevents icon output)
 * @param: Boolean that indicates if this is a build of the template
 * @param: 'text', 'number' or 'currency'. Sets the data-type attribute
 * @param: The error message that will be displayed when this input
 *         fails the validation that belongs to the type.
 * @param: Readonly, boolean that indicates if the input should be
 *         readonly
*}
{function name=ProductInputFormElement size='1-of-1' fieldname='' value='' iconlib='utility' icon='' istemplate=false type='text' error='' readonly=false}
<div class="slds-form-element slds-size_{$size}">
	<div class="slds-form-element__control {if $icon != 'none'}slds-input-has-icon slds-input-has-icon_left{/if}">
		<input type="text" data-type="{$type}"{if $readonly} readonly="readonly"{/if}data-error-mess="{$error}" class="slds-input {$productline_inputprefix}--{$fieldname}" value="{if !$istemplate}{$value}{/if}"/>
		{if $icon != 'none'}
		{call name=LDSIcon lib=$iconlib icon=$icon align='left' size='x-small'}
		{/if}
	</div>
	<div class="slds-form-element__help cbds-form-element__help--fixed"></div>
</div>
{/function}

{*
 * Function: ProductDropdownFormElement
 * ----------------------------------------------------------------------
 * Outputs a form element with a dropdown
 *
 * @param: The size of the form element, check LDS documentation
 * 			on: https://www.lightningdesignsystem.com/utilities/sizing
 * @param: The fieldname, should be the coreBOS fieldname
 * @param: The value, the value of the input field, if any
 * @param: The placeholder text
 * @param: Flat array of options that the dropdown should include
 * @param: Boolean that indicates if this is a build of the template
*}
{function name=ProductDropdownFormElement size='1-of-1' fieldname='' value='' placeholder='' options=[] istemplate=false}
<div class="slds-form-element slds-size_{$size}">
	<div class="slds-form-element__control">
		<div class="slds-combobox_container">
			<div class="slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-combobox-picklist" aria-expanded="false" aria-haspopup="listbox" role="combobox">
				<div class="slds-combobox__form-element slds-input-has-icon slds-input-has-icon_right" role="none">
					<input class="slds-input slds-combobox__input cbds-product-line-{$fieldname}" aria-controls="" autocomplete="off" role="textbox" placeholder="{$placeholder}" readonly="readonly" type="text" value="{$value}"/>
					{call name=LDSIcon lib='utility' icon='down' align='right' size='x-small'}
				</div>
				<div role="listbox">
					<ul class="slds-listbox slds-listbox_vertical slds-dropdown slds-dropdown_fluid" role="presentation">
						{foreach from=$options item=option key=key name=name}
						<li role="presentation" class="slds-listbox__item">
							<div class="slds-listbox__option slds-listbox__option_plain" role="option">
								<span class="slds-media__body">
									<span class="slds-truncate" title="{$option}">{$option}</span>
								</span>
							</div>
						</li>
						{/foreach}
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
{/function}

{*
 * Function: LDSIcon
 * ----------------------------------------------------------------------
 * Outputs a LDS icon, optionally with a container
 *
 * @param: The library for the icon, can be 'corebos' or one of the
 * 			ones mentioned on https://www.lightningdesignsystem.com/icons
 * @param: The icon name
 * @param: Where the icon should align: 'left' or 'right'
 * @param: The size: https://www.lightningdesignsystem.com/utilities/sizing
 * @param: Boolean that indicates of a container should be used
*}
{function name=LDSIcon lib='utility' icon='' align='left' size='x-small' container=true}
{if $container}<span class="slds-icon_container slds-icon-{$lib}-{$icon} slds-input__icon slds-input__icon_{$align}">{/if}
	<svg class="slds-icon slds-icon slds-icon_{$size} slds-icon-text-default" aria-hidden="true">
		<use xlink:href="lib/LDS/icons/{$lib}-sprite/svg/symbols.svg#{$icon}" xmlns:xlink="http://www.w3.org/1999/xlink" />
	</svg>
{if $container}</span>{/if}
{/function}

{*
 * Function: LDSButton
 * ----------------------------------------------------------------------
 * Outputs a LDS button, optionally with an icon
 *
 * @param: The HTML tag to be used, defaults to 'button'
 * @param: The icon library name, could be 'corebos' or any one
 *			from https://www.lightningdesignsystem.com/icons
 * @param: The icon name, or 'none' (prevents icon from being output)
 * @param: The icon size
 * @param: An optional extra class to be given to the element
 * @param: The button title (used on hovers)
*}
{function name=LDSButton el='button' iconlib='utility' icon='' iconsize='x-small' extraclass='' title=''}
<{$el} class="slds-button{if $icon != 'none'} slds-button_icon slds-button_icon-border-filled{/if}{if extraclass != ''} {$extraclass}{/if}" title="{$title}" aria-pressed="false">
	{if $icon != ''}
	{call name=LDSIcon lib=$iconlib icon=$icon size=$iconsize container=false}
	{/if}
	<span class="slds-assistive-text">Copy this line</span>
</{$el}>
{/function}