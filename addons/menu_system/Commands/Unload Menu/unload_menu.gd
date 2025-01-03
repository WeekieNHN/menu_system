extends Command

func run_command(args: Array[String]) -> String:
	if MenuManager.active_menu == null:
		return "Menu System: No active menu to unload."
	# Save menu name for unloaded menu
	var menu_name = MenuManager.active_menu.menu_ref.menu_name
	# Unload the current menu
	MenuManager.unload_menu()
	# Return an empty string
	return "Menu System: Unloaded %s.\n" % menu_name
