extends Node

@export_group("Start Menu")
@export var start_menu: MenuReference = null

@export_group("Menus")
@export var menus: Array[MenuReference] = []

var active_menu: Menu = null
var menu_scenes = {} 

@onready var menu_layer: CanvasLayer = $MenuLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Preload each menu to scenes dict
	for ref in menus:
		# Only accept existing references
		if ref == null: continue
		# Validate that menu scene exists
		if ref.menu_path == "" or !ResourceLoader.exists(ref.menu_path):
			print("MenuSystem: Invalid path associated with '%s'" % ref.menu_name)
			continue
		# Otherwise load valid Menu Reference to dict
		menu_scenes[ref.menu_name] = load(ref.menu_path)
	# Check if start menu path is given and resource exists
	# If so, load the start menu
	if start_menu == null:
		print("MenuSystem: No Start Menu path given.")
	elif !ResourceLoader.exists(start_menu.menu_path):
		print("MenuSystem: No resource exists at %s." % start_menu.menu_path)
	else:
		load_menu(start_menu.menu_name) # Load start menu with no args

func load_menu(menu_name: String, load_args = null) -> void:
	# Get menu from name
	if !menu_scenes.has(menu_name):
		print("MenuSystem: No menu associated with '%s'" % menu_name)
		return
	# We have a valid menu
	print("MenuSystem: Loading Menu - %s (%s)" % [menu_name, str(load_args)])
	# If menu is loaded, unload it
	if active_menu != null: unload_menu("Force")
	# Load the menu
	active_menu = menu_scenes[menu_name].instantiate()
	# Add active menu to menu_layer
	menu_layer.add_child(active_menu)
	# load menu w/ load args
	active_menu.load_menu(load_args)

func unload_menu(unload_args = null) -> void:
	# Check if there is a menu to unload
	if active_menu == null: return
	# Otherwise, unload the menu
	print("MenuSystem: Unloading Menu - %s (%s)" % [active_menu.name, str(unload_args)])
	# Call unload on the menu
	active_menu.unload_menu(unload_args)
	# Remove the menu from the node tree
	menu_layer.remove_child(active_menu) # So that names don't get screwed up while the menu is queued to be freed
	active_menu.queue_free()
	active_menu = null # Nullify the variable so it can be set again
