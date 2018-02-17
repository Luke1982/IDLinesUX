{* Define the product line component *}
{function name=InventoryLine template=false data=[]}
<!-- LDS Detail line for inventorydetails -->
<div class="cbds-detail-line slds-p-vertical_small{if $template} cbds-detail-line--template{/if}">
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
										<input class="slds-input slds-combobox__input" aria-autocomplete="list" aria-controls="listbox-unique-id" autocomplete="off" role="textbox" placeholder="Search Products and services" type="text" value="{if !$template}{$data.meta.name}{/if}" />
										{call name=LDSIcon lib='utility' icon='search' align='right' size='x-small'}
									</div>
								</div>
							</div>
						</div>
						<!-- // Product name form element -->
						<!-- Product quantity form element -->
						<div class="slds-form-element slds-size_1-of-8">
							<div class="slds-form-element__control">
								<input type="text" class="slds-input cbds-product-qty" value="{if !$template}{$data.meta.quantity}{/if}" />
							</div>
						</div>
						<!-- // Product quantity form element -->
						<!-- Discount type form element -->
						{if $data.meta.discount_type == 'p'}{$curval = 'Percentage'}{else}{$curval = 'Direct'}{/if}
						{$options = ['Direct', 'Percentage']}
						{call name=ProductDropdownFormElement size='1-of-8' fieldname='discount_type' value=$curval placeholder='Discount type' options=$options istemplate=$template}
						<!-- // Discount type form element -->
						<!-- Discount number (percent/direct) form element -->
						{call name=ProductIconFormElement size='1-of-8' fieldname='discount_amount' value=$data.meta.discount_amount icon='percent' istemplate=$template}
						<!-- // Discount number (percent/direct) form element -->
						<!-- Discount amount form element -->
						{$discount_total = $data.meta.extgross - $data.meta.extnet}
						{call name=ProductIconFormElement size='1-of-8' fieldname='discount_total' value=$discount_total icon='euro' istemplate=$template}
						<!-- // Discount amount form element -->
						<!-- Line total form element -->
						{call name=ProductIconFormElement size='1-of-8' fieldname='linetotal' value=$data.meta.linetotal icon='euro' istemplate=$template}
						<!-- // Line total form element -->
					</div>
				</div>
			</fieldset>
		</div>
		<!-- // Nested column with input fields -->
		<!-- LDS Line tools column -->
		<div class="slds-col slds-size_2-of-12 slds-align-middle">
			<div class="slds-button-group">
				<div class="slds-button slds-button_icon slds-button_icon-border-filled cbds-detail-line-dragtool" title="Drag this line" aria-pressed="false">
					<svg class="slds-button__icon" aria-hidden="true">
						<use xlink:href="lib/LDS/icons/utility-sprite/svg/symbols.svg#move"></use>
					</svg>
					<span class="slds-assistive-text">Drag this line to another location</span>
				</div>
				<button class="slds-button slds-button_icon slds-button_icon-border-filled cbds-detail-line-copytool" title="Copy this line" aria-pressed="false">
					<svg class="slds-button__icon" aria-hidden="true">
						<use xlink:href="lib/LDS/icons/utility-sprite/svg/symbols.svg#copy"></use>
					</svg>
					<span class="slds-assistive-text">Copy this line</span>
				</button>
				<button class="slds-button slds-button_icon slds-button_icon-border-filled cbds-button--delete cbds-detail-line-deletetool" title="Delete this line" aria-pressed="false">
					<svg class="slds-button__icon" aria-hidden="true">
						<use xlink:href="lib/LDS/icons/utility-sprite/svg/symbols.svg#delete"></use>
					</svg>
					<span class="slds-assistive-text">Delete this line</span>
				</button>
				<button class="slds-button slds-button_icon slds-button_icon-border-filled cbds-detail-line-extratool" title="Expand or collapse this line" aria-pressed="false">
					<svg class="slds-button__icon" aria-hidden="true">
						<use xlink:href="lib/LDS/icons/utility-sprite/svg/symbols.svg#switch"></use>
					</svg>
					<span class="slds-assistive-text">Expand or collapse this line</span>
				</button>
			</div>
		</div>
		<!-- // LDS Line tools column -->
	</div>
	<!-- // Main LDS inventory details line -->
	<!-- Extra LDS inventory line -->
	<div class="slds-grid slds-gutters slds-p-vertical_medium cbds-detail-line__extra">
		<!-- LDS extra inventoryline column -->
		<div class="slds-col slds-size_1-of-4">
			<div class="slds-panel">
				<div class="cbds-panelheader">
					<div class="slds-text-color_inverse slds-align_absolute-center">Pricing</div>
				</div>
				<div class="slds-form slds-form_stacked slds-grow">
					{call name=ProductPanelSection fieldname='cost_price' label='Unit cost price' value=$data.pricing.cost_price symbol='euro'}
					{call name=ProductPanelSection fieldname='cost_gross' label='Line cost price' value=$data.pricing.cost_gross symbol='euro'}
					{call name=ProductPanelSection fieldname='unit_price' label='Line cost price' value=$data.pricing.unit_price symbol='euro'}
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
								<textarea rows="10" class="slds-textarea cbds-product-line-comments" placeholder="Type a comment">{if $data.meta.description != ''}{$data.meta.description}{/if}</textarea>
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

{function name=ProductPanelSection fieldname='' label='' value='' symbol='euro'}
<div class="slds-panel__section slds-border_bottom">
	<label class="slds-form-element__label">{$label}</label>
	<div class="slds-form-element__control{if $symbol != 'none'} slds-input-has-icon slds-input-has-icon_left{/if}">
		<input type="text" class="slds-input cbds-product-line-{$fieldname}" value="{$value}" />
		{if $symbol != 'none'}
			{call name=LDSIcon lib='corebos' icon=$symbol align='left' size='x-small'}
		{/if}
	</div>
</div>
{/function}

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
				<input type="text" class="slds-input" value="{$amount}" />
				{call name=LDSIcon lib='corebos' icon=$symbol align='left' size='x-small'}
			</div>
		</div>
	</div>
</div>
{/function}

{function name=ProductIconFormElement size='1-of-1' fieldname='' value='' icon='' istemplate=false}
<div class="slds-form-element slds-size_{$size}">
	<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
		<input type="text" class="slds-input cbds-product-{$fieldname}" value="{if !$istemplate}{$value}{/if}"/>
		{call name=LDSIcon lib='corebos' icon=$icon align='left' size='x-small'}
	</div>
</div>
{/function}

{function name=ProductDropdownFormElement size='1-of-1' fieldname='' value='' placeholder='' options=[] istemplate=false}
<div class="slds-form-element slds-size_{$size}">
	<div class="slds-form-element__control">
		<div class="slds-combobox_container">
			<div class="slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-combobox-picklist" aria-expanded="false" aria-haspopup="listbox" role="combobox">
				<div class="slds-combobox__form-element slds-input-has-icon slds-input-has-icon_right" role="none">
					<input class="slds-input slds-combobox__input cbds-productline-{$fieldname}" aria-controls="" autocomplete="off" role="textbox" placeholder="{$placeholder}" readonly="readonly" type="text" value="{$value}"/>
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

{function name=LDSIcon lib='utility' icon='' align='left' size='x-small'}
<span class="slds-icon_container slds-icon-{$lib}-{$icon} slds-input__icon slds-input__icon_{$align}">
	<svg class="slds-icon slds-icon slds-icon_{$size} slds-icon-text-default" aria-hidden="true">
		<use xlink:href="lib/LDS/icons/{$lib}-sprite/svg/symbols.svg#{$icon}" xmlns:xlink="http://www.w3.org/1999/xlink" />
	</svg>
</span>
{/function}