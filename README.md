# Mockup repo for setting up InventoryDetail lines (as a detail module) in coreBOS
This repo is used as a simple way to collaborate on a HTML/CSS/JS structure that we can later on implement into coreBOS. The reason for this repo is to be more flexible and efficiënt in setting up a basic structure so that we don't need to alter code in multiple places when developing.

## The things we will develop here
* A basic HTML structure, using BEM as a styleguide.
* The Javascript for the UX side of things. Meaning:
	* Dragging the order of the lines
	* Developing an autocomplete function for products and services
	* Expanding and collapsing certain parts of the lines
* A CSS system prefixed with "cbds-" (CoreBos Design System, yes, stolen from LDS) that'll allow us to setup re-useable CSS classes for further Master-Detail implementations.

## What we will **not** develop here
* The actual CRUD operations, since they require being in an actual coreBOS environment. Those will be dealt with when this repo is 'done'.

## To-do
* ~~Implement auto-creation of an autocomplete instance in the InventoryLine module.~~
* ~~Create a module for the collection of lines~~
* Implement Smarty to better create a Component for the line and test PHP arrays
* Create aggregations (and a module for it)
* Merge all JS modules into a single file
* Create a throttle function in the JS modules to avoid slow screen response