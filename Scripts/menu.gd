class_name Menu extends Control

@export var menu_ref: MenuReference

# Hook any on_load logic to this signal
signal on_menu_loaded
# Hook any on_unload logic to this signal
signal on_menu_unloaded

@export_group("Focus")
@export var focus_start_node: Control

# Always call super() to make sure logic is working
func load_menu(_load_args) -> void:
	# Emit signal
	on_menu_loaded.emit()
	# Grab focus
	menu_grab_focus()

# Always call super() to make sure all logic is working
func unload_menu(_unload_args):
	# Emit signal
	on_menu_unloaded.emit()

func menu_grab_focus() -> void:
	# Grab focus
	focus_start_node.grab_focus()
