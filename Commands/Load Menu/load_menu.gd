extends Command

func run_command(args: Array[String]) -> String:
	# Check if arg0 is given
	if len(args) == 0:
		return "Menu System: No menu was specified to load. Please select one from this list:\n\n%s\n\n" % [MenuManager.menu_scenes.keys()]
	elif !MenuManager.menu_scenes.has(args[0]):
		return "Menu System: Menu `%s` could not be found. Please select one from this list:\n\n%s\n\n" % [args[0], MenuManager.menu_scenes.keys()]
	else:
		# Load the menu
		MenuManager.load_menu(args[0], "Command")
		# Return message
		return "Menu System: Loaded menu `%s`.\n" % args[0]
