extends Node


@export_group("Menu Configuration")
@export var menu_config: MenuConfig = preload("res://addons/menu_system/demo_menu_config.tres")

var start_menu_name: String = ""
var menus: Dictionary[String, String] = {} # KVPs are menu_name, menu_path

var active_menu: Menu = null
var menu_scenes: Dictionary = {} 

@onready var menu_layer: CanvasLayer = $MenuLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Load menus from resource
	menus = menu_config.menus
	start_menu_name = menu_config.start_menu_name
	# Preload each menu to scenes
	for key in menus:
		# Get key so we can operate with key-value pairs
		var value = menus[key]
		# Skip if key or value is empty
		if key == "" or value == "": continue
		# Skip if menu scene doesn't exist
		if !ResourceLoader.exists(value):
			print("MenuSystem: Invalid path associated with '%s'" % key)
			continue
		# Otherwise, load menu to menu scenes dict
		menu_scenes[key] = load(value)
	
	# Check if start menu path is given and resource exists
	# If so, load the start menu
	if start_menu_name == "":
		print("MenuSystem: No Start Menu path given.")
	elif !menus.has(start_menu_name):
		print("MenuSystem: Start Menu path is not found in menu dictionary.")
	elif !ResourceLoader.exists(menus[start_menu_name]):
		print("MenuSystem: No resource exists at %s." % menus[start_menu_name])
	else:
		load_menu(start_menu_name) # Load start menu with no args

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
	print(menu_scenes[menu_name].instantiate())
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
