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
	<script type="text/javascript" src="InventoryBlock.js"></script>
	<script type="text/javascript" src="ProductAutocomplete.js"></script>
	<script type="text/javascript" src="ldsCombobox.js"></script>
</head>
<body>
	<div id="testcontainer">
		<!-- Detail block -->
		<div class="cbds-detail-block cbds-inventory-block">
			<!-- Detail line preheader -->
			<div class="slds-grid slds-p-vertical_medium cbds-detail-line-preheader">
				<div class="slds-col slds-size_10-of-12 slds-p-left_medium">
					<span class="slds-icon_container slds-icon-utility-shopping_bag" title="Add products or services">
						<svg class="slds-icon slds-icon-text-default slds-icon slds-icon-text-light" aria-hidden="true">
							<use xlink:href="lib/LDS/icons/utility-sprite/svg/symbols.svg#shopping_bag" xmlns:xlink="http://www.w3.org/1999/xlink" />
						</svg>
						<span class="slds-assistive-text">Description of icon when needed</span>
					</span>						
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
				<div class="slds-col slds-size_1-of-12 slds-p-left_medium">
					<div class="slds-text-title_caps slds-text-color_inverse">Image</div>
				</div>
				<div class="slds-col slds-gutters_x-large slds-size-9-of-12">
					<div class="slds-grid">
						<div class="slds-col slds-size_2-of-8">
							<div class="slds-text-title_caps slds-text-color_inverse">Product name</div>
						</div>
						<div class="slds-col slds-size_1-of-8">
							<div class="slds-text-title_caps slds-text-color_inverse">Quantity</div>
						</div>
						<div class="slds-col slds-size_1-of-8">
							<div class="slds-text-title_caps slds-text-color_inverse">Discount type</div>
						</div>
						<div class="slds-col slds-size_1-of-8">
							<div class="slds-text-title_caps slds-text-color_inverse">Discount</div>
						</div>
						<div class="slds-col slds-size_1-of-8">
							<div class="slds-text-title_caps slds-text-color_inverse">Discount amount</div>
						</div>
						<div class="slds-col slds-size_1-of-8">
							<div class="slds-text-title_caps slds-text-color_inverse">Line total</div>
						</div>
					</div>
				</div>
				<div class="slds-col slds-size_2-of-12">
					<div class="slds-text-title_caps slds-p-left_large slds-text-color_inverse">Line tools</div>
				</div>
			</div>
			<!-- // LDS Detail line header -->
			<div class="cbds-detail-lines">
				<!-- LDS Detail line for inventorydetails -->
				<div class="cbds-detail-line slds-p-vertical_small">
					<!-- Main LDS inventory details line -->
					<div class="slds-grid slds-gutters cbds-detail-line__main">
						<div class="slds-col slds-size_1-of-12">
							<div class="cbds-image-container cbds-image-container--small">
								<img src="images/sprite.jpg" class="cbds-image cbds-product-line-image" />
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
														<input class="slds-input slds-combobox__input" aria-autocomplete="list" aria-controls="listbox-unique-id" autocomplete="off" role="textbox" placeholder="Search Products and services" type="text" />
														<span class="slds-icon_container slds-icon-utility-search slds-input__icon slds-input__icon_right">
															<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
																<use xlink:href="lib/LDS/icons/utility-sprite/svg/symbols.svg#search" xmlns:xlink="http://www.w3.org/1999/xlink" />
															</svg>
														</span>
													</div>
												</div>
											</div>
										</div>
										<!-- // Product name form element -->
										<!-- Product quantity form element -->
										<div class="slds-form-element slds-size_1-of-8">
											<div class="slds-form-element__control">
												<input type="text" class="slds-input cbds-product-qty" />
											</div>
										</div>
										<!-- // Product quantity form element -->
										<!-- Discount type form element -->
										<div class="slds-form-element slds-size_1-of-8">
											<div class="slds-form-element__control">
												<div class="slds-combobox_container">
													<div class="slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-combobox-picklist" aria-expanded="false" aria-haspopup="listbox" role="combobox">
														<div class="slds-combobox__form-element slds-input-has-icon slds-input-has-icon_right" role="none">
															<input class="slds-input slds-combobox__input" aria-controls="" autocomplete="off" role="textbox" placeholder="Discount type" readonly="readonly" type="text" />
															<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_right">
																<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
																	<use xlink:href="lib/LDS/icons/utility-sprite/svg/symbols.svg#down" xmlns:xlink="http://www.w3.org/1999/xlink" />
																</svg>
															</span>
														</div>
														<div role="listbox">
															<ul class="slds-listbox slds-listbox_vertical slds-dropdown slds-dropdown_fluid" role="presentation">
																<li role="presentation" class="slds-listbox__item">
																	<div class="slds-listbox__option slds-listbox__option_plain" role="option">
																		<span class="slds-media__body">
																			<span class="slds-truncate" title="Direct">Direct</span>
																		</span>
																	</div>
																</li>
																<li role="presentation" class="slds-listbox__item">
																	<div class="slds-listbox__option slds-listbox__option_plain" role="option">
																		<span class="slds-media__body">
																			<span class="slds-truncate" title="Percentage">Percentage</span>
																		</span>
																	</div>
																</li>
															</ul>
														</div>
													</div>
												</div>
											</div>
										</div>
										<!-- // Discount type form element -->
										<!-- Discount number (percent/direct) form element -->
										<div class="slds-form-element slds-size_1-of-8">
											<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
												<input type="text" class="slds-input cbds-product-qty" />
												<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_right">
													<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
														<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#percent" xmlns:xlink="http://www.w3.org/1999/xlink" />
													</svg>
												</span>
											</div>
										</div>
										<!-- // Discount number (percent/direct) form element -->
										<!-- Discount amount form element -->
										<div class="slds-form-element slds-size_1-of-8">
											<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
												<input type="text" class="slds-input cbds-product-qty" />
												<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_right">
													<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
														<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#euro" xmlns:xlink="http://www.w3.org/1999/xlink" />
													</svg>
												</span>
											</div>
										</div>
										<!-- // Discount amount form element -->
										<!-- Line total form element -->
										<div class="slds-form-element slds-size_1-of-8">
											<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
												<input type="text" class="slds-input cbds-product-qty" />
												<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_right">
													<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
														<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#euro" xmlns:xlink="http://www.w3.org/1999/xlink" />
													</svg>
												</span>
											</div>
										</div>
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
									<div class="slds-panel__section slds-border_bottom">
										<label class="slds-form-element__label">Unit cost price</label>
										<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
											<input type="text" class="slds-input cbds-product-line-unitcost" />
											<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_left">
												<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
													<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#euro" xmlns:xlink="http://www.w3.org/1999/xlink" />
												</svg>
											</span>
										</div>
									</div>
									<div class="slds-panel__section slds-border_bottom">
										<label class="slds-form-element__label">Line cost price</label>
										<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
											<input type="text" class="slds-input" />
											<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_left">
												<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
													<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#euro" xmlns:xlink="http://www.w3.org/1999/xlink" />
												</svg>
											</span>
										</div>
									</div>
									<div class="slds-panel__section slds-border_bottom">
										<label class="slds-form-element__label">List price</label>
										<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
											<input type="text" class="slds-input cbds-product-line-listprice" />
											<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_left">
												<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
													<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#euro" xmlns:xlink="http://www.w3.org/1999/xlink" />
												</svg>
											</span>
										</div>
									</div>
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
									<div class="slds-panel__section slds-border_bottom">
										<span class="slds-form-element__label">Units delivered / received</span>
										<div class="slds-form-element__control">
											<input type="text" class="slds-input" />
										</div>
									</div>
									<div class="slds-panel__section slds-border_bottom">
										<span class="slds-form-element__label">Qty in stock</span>
										<div class="slds-form-element__control">
											<input type="text" class="slds-input cbds-product-line-qtyinstock" />
										</div>
									</div>
									<div class="slds-panel__section slds-border_bottom">
										<span class="slds-form-element__label">Currently ordered</span>
										<div class="slds-form-element__control">
											<input type="text" class="slds-input cbds-product-line-currordered" />
										</div>
									</div>
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
									<div class="slds-panel__section slds-border_bottom">
										<span class="slds-form-element__label">Tax 1</span>
										<div class="slds-form-element__row cbds-m-bottom_none">
											<div class="slds-form-element slds-size_5-of-12">
												<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
													<input type="text" class="slds-input" />
													<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_left">
														<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
															<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#percent" xmlns:xlink="http://www.w3.org/1999/xlink" />
														</svg>
													</span>
												</div>
											</div>
											<div class="slds-form-element slds-size_7-of-12">
												<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
													<input type="text" class="slds-input" />
													<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_left">
														<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
															<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#euro" xmlns:xlink="http://www.w3.org/1999/xlink" />
														</svg>
													</span>
												</div>
											</div>
										</div>
									</div>
									<div class="slds-panel__section slds-border_bottom">
										<span class="slds-form-element__label">Tax 2</span>
										<div class="slds-form-element__row cbds-m-bottom_none">
											<div class="slds-form-element slds-size_5-of-12">
												<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
													<input type="text" class="slds-input" />
													<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_left">
														<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
															<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#percent" xmlns:xlink="http://www.w3.org/1999/xlink" />
														</svg>
													</span>
												</div>
											</div>
											<div class="slds-form-element slds-size_7-of-12">
												<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
													<input type="text" class="slds-input" />
													<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_left">
														<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
															<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#euro" xmlns:xlink="http://www.w3.org/1999/xlink" />
														</svg>
													</span>
												</div>
											</div>
										</div>
									</div>
									<div class="slds-panel__section slds-border_bottom">
										<span class="slds-form-element__label">Tax 3</span>
										<div class="slds-form-element__row cbds-m-bottom_none">
											<div class="slds-form-element slds-size_5-of-12">
												<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
													<input type="text" class="slds-input" />
													<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_left">
														<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
															<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#percent" xmlns:xlink="http://www.w3.org/1999/xlink" />
														</svg>
													</span>
												</div>
											</div>
											<div class="slds-form-element slds-size_7-of-12">
												<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
													<input type="text" class="slds-input" />
													<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_left">
														<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
															<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#euro" xmlns:xlink="http://www.w3.org/1999/xlink" />
														</svg>
													</span>
												</div>
											</div>
										</div>
									</div>									
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
												<textarea rows="10" class="slds-textarea cbds-product-line-comments" placeholder="Type a comment"></textarea>
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
				<!-- LDS Detail line for inventorydetails -->
				<div class="cbds-detail-line slds-p-vertical_small">
					<!-- Main LDS inventory details line -->
					<div class="slds-grid slds-gutters cbds-detail-line__main">
						<div class="slds-col slds-size_1-of-12">
							<div class="cbds-image-container cbds-image-container--small">
								<img src="images/sprite.jpg" class="cbds-image cbds-product-line-image" />
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
														<input class="slds-input slds-combobox__input" aria-autocomplete="list" aria-controls="listbox-unique-id" autocomplete="off" role="textbox" placeholder="Search Products and services" type="text" />
														<span class="slds-icon_container slds-icon-utility-search slds-input__icon slds-input__icon_right">
															<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
																<use xlink:href="lib/LDS/icons/utility-sprite/svg/symbols.svg#search" xmlns:xlink="http://www.w3.org/1999/xlink" />
															</svg>
														</span>
													</div>
												</div>
											</div>
										</div>
										<!-- // Product name form element -->
										<!-- Product quantity form element -->
										<div class="slds-form-element slds-size_1-of-8">
											<div class="slds-form-element__control">
												<input type="text" class="slds-input cbds-product-qty" />
											</div>
										</div>
										<!-- // Product quantity form element -->
										<!-- Discount type form element -->
										<div class="slds-form-element slds-size_1-of-8">
											<div class="slds-form-element__control">
												<div class="slds-combobox_container">
													<div class="slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-combobox-picklist" aria-expanded="false" aria-haspopup="listbox" role="combobox">
														<div class="slds-combobox__form-element slds-input-has-icon slds-input-has-icon_right" role="none">
															<input class="slds-input slds-combobox__input" aria-controls="" autocomplete="off" role="textbox" placeholder="Discount type" readonly="readonly" type="text" />
															<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_right">
																<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
																	<use xlink:href="lib/LDS/icons/utility-sprite/svg/symbols.svg#down" xmlns:xlink="http://www.w3.org/1999/xlink" />
																</svg>
															</span>
														</div>
														<div role="listbox">
															<ul class="slds-listbox slds-listbox_vertical slds-dropdown slds-dropdown_fluid" role="presentation">
																<li role="presentation" class="slds-listbox__item">
																	<div class="slds-listbox__option slds-listbox__option_plain" role="option">
																		<span class="slds-media__body">
																			<span class="slds-truncate" title="Direct">Direct</span>
																		</span>
																	</div>
																</li>
																<li role="presentation" class="slds-listbox__item">
																	<div class="slds-listbox__option slds-listbox__option_plain" role="option">
																		<span class="slds-media__body">
																			<span class="slds-truncate" title="Percentage">Percentage</span>
																		</span>
																	</div>
																</li>
															</ul>
														</div>
													</div>
												</div>
											</div>
										</div>
										<!-- // Discount type form element -->
										<!-- Discount number (percent/direct) form element -->
										<div class="slds-form-element slds-size_1-of-8">
											<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
												<input type="text" class="slds-input cbds-product-qty" />
												<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_right">
													<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
														<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#percent" xmlns:xlink="http://www.w3.org/1999/xlink" />
													</svg>
												</span>
											</div>
										</div>
										<!-- // Discount number (percent/direct) form element -->
										<!-- Discount amount form element -->
										<div class="slds-form-element slds-size_1-of-8">
											<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
												<input type="text" class="slds-input cbds-product-qty" />
												<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_right">
													<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
														<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#euro" xmlns:xlink="http://www.w3.org/1999/xlink" />
													</svg>
												</span>
											</div>
										</div>
										<!-- // Discount amount form element -->
										<!-- Line total form element -->
										<div class="slds-form-element slds-size_1-of-8">
											<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
												<input type="text" class="slds-input cbds-product-qty" />
												<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_right">
													<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
														<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#euro" xmlns:xlink="http://www.w3.org/1999/xlink" />
													</svg>
												</span>
											</div>
										</div>
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
									<div class="slds-panel__section slds-border_bottom">
										<label class="slds-form-element__label">Unit cost price</label>
										<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
											<input type="text" class="slds-input cbds-product-line-unitcost" />
											<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_left">
												<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
													<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#euro" xmlns:xlink="http://www.w3.org/1999/xlink" />
												</svg>
											</span>
										</div>
									</div>
									<div class="slds-panel__section slds-border_bottom">
										<label class="slds-form-element__label">Line cost price</label>
										<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
											<input type="text" class="slds-input" />
											<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_left">
												<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
													<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#euro" xmlns:xlink="http://www.w3.org/1999/xlink" />
												</svg>
											</span>
										</div>
									</div>
									<div class="slds-panel__section slds-border_bottom">
										<label class="slds-form-element__label">List price</label>
										<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
											<input type="text" class="slds-input cbds-product-line-listprice" />
											<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_left">
												<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
													<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#euro" xmlns:xlink="http://www.w3.org/1999/xlink" />
												</svg>
											</span>
										</div>
									</div>
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
									<div class="slds-panel__section slds-border_bottom">
										<span class="slds-form-element__label">Units delivered / received</span>
										<div class="slds-form-element__control">
											<input type="text" class="slds-input" />
										</div>
									</div>
									<div class="slds-panel__section slds-border_bottom">
										<span class="slds-form-element__label">Qty in stock</span>
										<div class="slds-form-element__control">
											<input type="text" class="slds-input cbds-product-line-qtyinstock" />
										</div>
									</div>
									<div class="slds-panel__section slds-border_bottom">
										<span class="slds-form-element__label">Currently ordered</span>
										<div class="slds-form-element__control">
											<input type="text" class="slds-input cbds-product-line-currordered" />
										</div>
									</div>
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
									<div class="slds-panel__section slds-border_bottom">
										<span class="slds-form-element__label">Tax 1</span>
										<div class="slds-form-element__row cbds-m-bottom_none">
											<div class="slds-form-element slds-size_5-of-12">
												<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
													<input type="text" class="slds-input" />
													<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_left">
														<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
															<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#percent" xmlns:xlink="http://www.w3.org/1999/xlink" />
														</svg>
													</span>
												</div>
											</div>
											<div class="slds-form-element slds-size_7-of-12">
												<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
													<input type="text" class="slds-input" />
													<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_left">
														<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
															<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#euro" xmlns:xlink="http://www.w3.org/1999/xlink" />
														</svg>
													</span>
												</div>
											</div>
										</div>
									</div>
									<div class="slds-panel__section slds-border_bottom">
										<span class="slds-form-element__label">Tax 2</span>
										<div class="slds-form-element__row cbds-m-bottom_none">
											<div class="slds-form-element slds-size_5-of-12">
												<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
													<input type="text" class="slds-input" />
													<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_left">
														<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
															<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#percent" xmlns:xlink="http://www.w3.org/1999/xlink" />
														</svg>
													</span>
												</div>
											</div>
											<div class="slds-form-element slds-size_7-of-12">
												<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
													<input type="text" class="slds-input" />
													<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_left">
														<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
															<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#euro" xmlns:xlink="http://www.w3.org/1999/xlink" />
														</svg>
													</span>
												</div>
											</div>
										</div>
									</div>
									<div class="slds-panel__section slds-border_bottom">
										<span class="slds-form-element__label">Tax 3</span>
										<div class="slds-form-element__row cbds-m-bottom_none">
											<div class="slds-form-element slds-size_5-of-12">
												<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
													<input type="text" class="slds-input" />
													<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_left">
														<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
															<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#percent" xmlns:xlink="http://www.w3.org/1999/xlink" />
														</svg>
													</span>
												</div>
											</div>
											<div class="slds-form-element slds-size_7-of-12">
												<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
													<input type="text" class="slds-input" />
													<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_left">
														<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
															<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#euro" xmlns:xlink="http://www.w3.org/1999/xlink" />
														</svg>
													</span>
												</div>
											</div>
										</div>
									</div>									
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
												<textarea rows="10" class="slds-textarea cbds-product-line-comments" placeholder="Type a comment"></textarea>
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
			</div>
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
									<span class="slds-text-heading_small">Lines (<span class="cbds-detail-aggr-sum">3</span>)</span>
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
				<div class="slds-card__body">
					<ul class="slds-card__body_inner slds-grid slds-wrap slds-grid_pull-padded">
						<li class="slds-p-horizontal_small slds-size_1-of-1 slds-medium-size_1-of-4">
							<article class="slds-tile slds-tile_board">
								<h3 class="slds-tile__title slds-truncate slds-text-heading_small" title="Gross total">Gross total</h3>
								<div class="slds-tile__detail">
									<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
										<input type="text" readonly="readonly" class="slds-input cbds-detail-aggr__grosstotal" value="8.065,34" />
										<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_left">
											<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
												<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#euro" xmlns:xlink="http://www.w3.org/1999/xlink" />
											</svg>
										</span>
									</div>
								</div>
							</article>
						</li>
						<li class="slds-p-horizontal_small slds-size_1-of-1 slds-medium-size_1-of-4">
							<article class="slds-tile slds-tile_board">
								<h3 class="slds-tile__title slds-truncate slds-text-heading_small" title="Total discount">Total discount</h3>
								<div class="slds-tile__detail">
									<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
										<input type="text" readonly="readonly" class="slds-input cbds-detail-aggr__totaldiscount" value="5.000,98" />
										<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_left">
											<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
												<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#euro" xmlns:xlink="http://www.w3.org/1999/xlink" />
											</svg>
										</span>
									</div>
								</div>
							</article>
						</li>
						<li class="slds-p-horizontal_small slds-size_1-of-1 slds-medium-size_1-of-4">
							<article class="slds-tile slds-tile_board">
								<h3 class="slds-tile__title slds-truncate slds-text-heading_small" title="Total taxes">Total taxes</h3>
								<div class="slds-tile__detail">
									<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
										<input type="text" readonly="readonly" class="slds-input cbds-detail-aggr__totaltaxes" value="882,45" />
										<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_left">
											<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
												<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#euro" xmlns:xlink="http://www.w3.org/1999/xlink" />
											</svg>
										</span>
									</div>
								</div>
							</article>
						</li>
						<li class="slds-p-horizontal_small slds-size_1-of-1 slds-medium-size_1-of-4">
							<article class="slds-tile slds-tile_board">
								<h3 class="slds-tile__title slds-truncate slds-text-heading_small" title="Net total">Net total</h3>
								<div class="slds-tile__detail">
									<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
										<input type="text" readonly="readonly" class="slds-input cbds-detail-aggr__nettotal" value="7.400,38" />
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
				</div>
			</article>
			<!-- // LDS Aggregations block -->
		</div>
		<!-- Detail block -->
		<!-- Template -->
		<!-- LDS Detail template line for inventorydetails -->
		<div class="cbds-detail-line cbds-detail-line--template slds-p-vertical_small">
			<!-- Main LDS inventory details line -->
			<div class="slds-grid slds-gutters cbds-detail-line__main">
				<div class="slds-col slds-size_1-of-12">
					<div class="cbds-image-container cbds-image-container--small">
						<img src="" class="cbds-image cbds-product-line-image" />
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
												<input class="slds-input slds-combobox__input" aria-autocomplete="list" aria-controls="listbox-unique-id" autocomplete="off" role="textbox" placeholder="Search Products and services" type="text" />
												<span class="slds-icon_container slds-icon-utility-search slds-input__icon slds-input__icon_right">
													<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
														<use xlink:href="lib/LDS/icons/utility-sprite/svg/symbols.svg#search" xmlns:xlink="http://www.w3.org/1999/xlink" />
													</svg>
												</span>
											</div>
										</div>
									</div>
								</div>
								<!-- // Product name form element -->
								<!-- Product quantity form element -->
								<div class="slds-form-element slds-size_1-of-8">
									<div class="slds-form-element__control">
										<input type="text" class="slds-input cbds-product-qty" />
									</div>
								</div>
								<!-- // Product quantity form element -->
								<!-- Discount type form element -->
								<div class="slds-form-element slds-size_1-of-8">
									<div class="slds-form-element__control">
										<div class="slds-combobox_container">
											<div class="slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-combobox-picklist" aria-expanded="false" aria-haspopup="listbox" role="combobox">
												<div class="slds-combobox__form-element slds-input-has-icon slds-input-has-icon_right" role="none">
													<input class="slds-input slds-combobox__input" aria-controls="" autocomplete="off" role="textbox" placeholder="Discount type" readonly="readonly" type="text" />
													<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_right">
														<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
															<use xlink:href="lib/LDS/icons/utility-sprite/svg/symbols.svg#down" xmlns:xlink="http://www.w3.org/1999/xlink" />
														</svg>
													</span>
												</div>
												<div role="listbox">
													<ul class="slds-listbox slds-listbox_vertical slds-dropdown slds-dropdown_fluid" role="presentation">
														<li role="presentation" class="slds-listbox__item">
															<div class="slds-listbox__option slds-listbox__option_plain" role="option">
																<span class="slds-media__body">
																	<span class="slds-truncate" title="Direct">Direct</span>
																</span>
															</div>
														</li>
														<li role="presentation" class="slds-listbox__item">
															<div class="slds-listbox__option slds-listbox__option_plain" role="option">
																<span class="slds-media__body">
																	<span class="slds-truncate" title="Percentage">Percentage</span>
																</span>
															</div>
														</li>
													</ul>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!-- // Discount type form element -->
								<!-- Discount number (percent/direct) form element -->
								<div class="slds-form-element slds-size_1-of-8">
									<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
										<input type="text" class="slds-input cbds-product-qty" />
										<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_right">
											<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
												<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#percent" xmlns:xlink="http://www.w3.org/1999/xlink" />
											</svg>
										</span>
									</div>
								</div>
								<!-- // Discount number (percent/direct) form element -->
								<!-- Discount amount form element -->
								<div class="slds-form-element slds-size_1-of-8">
									<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
										<input type="text" class="slds-input cbds-product-qty" />
										<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_right">
											<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
												<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#euro" xmlns:xlink="http://www.w3.org/1999/xlink" />
											</svg>
										</span>
									</div>
								</div>
								<!-- // Discount amount form element -->
								<!-- Line total form element -->
								<div class="slds-form-element slds-size_1-of-8">
									<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
										<input type="text" class="slds-input cbds-product-qty" />
										<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_right">
											<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
												<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#euro" xmlns:xlink="http://www.w3.org/1999/xlink" />
											</svg>
										</span>
									</div>
								</div>
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
							<div class="slds-panel__section slds-border_bottom">
								<label class="slds-form-element__label">Unit cost price</label>
								<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
									<input type="text" class="slds-input cbds-product-line-unitcost" />
									<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_left">
										<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
											<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#euro" xmlns:xlink="http://www.w3.org/1999/xlink" />
										</svg>
									</span>
								</div>
							</div>
							<div class="slds-panel__section slds-border_bottom">
								<label class="slds-form-element__label">Line cost price</label>
								<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
									<input type="text" class="slds-input" />
									<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_left">
										<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
											<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#euro" xmlns:xlink="http://www.w3.org/1999/xlink" />
										</svg>
									</span>
								</div>
							</div>
							<div class="slds-panel__section slds-border_bottom">
								<label class="slds-form-element__label">List price</label>
								<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
									<input type="text" class="slds-input cbds-product-line-listprice" />
									<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_left">
										<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
											<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#euro" xmlns:xlink="http://www.w3.org/1999/xlink" />
										</svg>
									</span>
								</div>
							</div>
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
							<div class="slds-panel__section slds-border_bottom">
								<span class="slds-form-element__label">Units delivered / received</span>
								<div class="slds-form-element__control">
									<input type="text" class="slds-input" />
								</div>
							</div>
							<div class="slds-panel__section slds-border_bottom">
								<span class="slds-form-element__label">Qty in stock</span>
								<div class="slds-form-element__control">
									<input type="text" class="slds-input cbds-product-line-qtyinstock" />
								</div>
							</div>
							<div class="slds-panel__section slds-border_bottom">
								<span class="slds-form-element__label">Currently ordered</span>
								<div class="slds-form-element__control">
									<input type="text" class="slds-input cbds-product-line-currordered" />
								</div>
							</div>
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
							<div class="slds-panel__section slds-border_bottom">
								<span class="slds-form-element__label">Tax 1</span>
								<div class="slds-form-element__row cbds-m-bottom_none">
									<div class="slds-form-element slds-size_5-of-12">
										<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
											<input type="text" class="slds-input" />
											<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_left">
												<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
													<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#percent" xmlns:xlink="http://www.w3.org/1999/xlink" />
												</svg>
											</span>
										</div>
									</div>
									<div class="slds-form-element slds-size_7-of-12">
										<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
											<input type="text" class="slds-input" />
											<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_left">
												<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
													<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#euro" xmlns:xlink="http://www.w3.org/1999/xlink" />
												</svg>
											</span>
										</div>
									</div>
								</div>
							</div>
							<div class="slds-panel__section slds-border_bottom">
								<span class="slds-form-element__label">Tax 2</span>
								<div class="slds-form-element__row cbds-m-bottom_none">
									<div class="slds-form-element slds-size_5-of-12">
										<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
											<input type="text" class="slds-input" />
											<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_left">
												<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
													<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#percent" xmlns:xlink="http://www.w3.org/1999/xlink" />
												</svg>
											</span>
										</div>
									</div>
									<div class="slds-form-element slds-size_7-of-12">
										<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
											<input type="text" class="slds-input" />
											<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_left">
												<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
													<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#euro" xmlns:xlink="http://www.w3.org/1999/xlink" />
												</svg>
											</span>
										</div>
									</div>
								</div>
							</div>
							<div class="slds-panel__section slds-border_bottom">
								<span class="slds-form-element__label">Tax 3</span>
								<div class="slds-form-element__row cbds-m-bottom_none">
									<div class="slds-form-element slds-size_5-of-12">
										<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
											<input type="text" class="slds-input" />
											<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_left">
												<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
													<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#percent" xmlns:xlink="http://www.w3.org/1999/xlink" />
												</svg>
											</span>
										</div>
									</div>
									<div class="slds-form-element slds-size_7-of-12">
										<div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_left">
											<input type="text" class="slds-input" />
											<span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_left">
												<svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
													<use xlink:href="lib/LDS/icons/corebos-sprite/svg/symbols.svg#euro" xmlns:xlink="http://www.w3.org/1999/xlink" />
												</svg>
											</span>
										</div>
									</div>
								</div>
							</div>									
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
										<textarea rows="10" class="slds-textarea cbds-product-line-comments" placeholder="Type a comment"></textarea>
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
		<!-- // LDS Detail template line for inventorydetails -->
		<!-- // Template -->
	</div>
</body>
</html>