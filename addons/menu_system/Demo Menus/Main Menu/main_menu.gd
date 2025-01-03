extends Menu

@onready var title_label: Label = %TitleLabel
@onready var version_label: Label = %VersionLabel
@onready var info_label: Label = %InfoLabel

@onready var online_button: Button = %OnlineButton
@onready var local_button: Button = %LocalButton
@onready var settings_button: Button = %SettingsButton
@onready var quit_button: Button = %QuitButton

# Always call super() to make sure all logic is working
func load_menu(_load_args) -> void:
	# Call super to emit signals
	super(_load_args)
	# Set the label texts for the main panel
	# Get the current time
	var current_date_time = Time.get_datetime_dict_from_system()
	# Setup the bottom corner text
	title_label.text = "%s" % ProjectSettings.get_setting("application/config/name")
	version_label.text = "%s v%s" % [ProjectSettings.get_setting("application/config/name"), ProjectSettings.get_setting("application/config/version")]
	info_label.text = "2016 - %s Nerd Herd Network" % current_date_time["year"]
	# Connect buttons
	quit_button.pressed.connect(on_quit_button_pressed)

func on_quit_button_pressed() -> void:
	# Quit the game
	get_tree().quit()
