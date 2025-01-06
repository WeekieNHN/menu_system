# GodotMenuSystem
A Simple Menu System with a demo Main Menu

## Installation

### Install/Enable Plugin and Confirm Autoload

1. Add `addons/menu_system` to your addons folder
2. Activate the plugin in `Project->Project Settings->Plugins`.  
3. The Global Autoload `menu_manager.tscn` should be enabled when the plugin is activated but confirm that it is in `Project->Project Settings->Globals`.

### Commands (How to remove them if you don't want them)

If you **do not** want to integrate with the [The Debug/Developer Console](https://github.com/WeekieNHN/GodotDevConsole), delete the `addons/menu_system/commands` folder, and remove the `MenuCommands` node from `addons/menu_system/Autoloads/menu_manager.tscn`. It will throw a compilation error on import if you do not have the console plugin installed.

If **do** want to integrate with the console: Just leave everything as is.

## How to Use

### Loading Menus

Menus can be loaded by calling `MenuManager.load_menu(menu_name: String, load_args)`

`menu_name` - a String menu name that corresponds to a `MenuReference` in the `menus` list.
`load_args` - argument that get passed to the menu. Can be any type.

### Unloading Menus

Menus can be loaded by calling `MenuManager.unload_menu(unload_args)`

`unload_args` - argument that get passed to the menu. Can be any type.

### Start Menu

If a `start_menu` is specified in the `MenuManager` it will be loaded on _ready().

### Focus

There is a `focus_start_node` variable in the Menu class which should be used to specific what control node to start focus on when the menu is loaded.

*Note: Focus (Controller Support) breaks if you load a menu from the console. This shouldn't really be an issue because the console cannot be accessed with a controller.*

### Signals

There are 2 signals for each menu. `on_menu_loaded` which runs on a menu being loaded, and `on_menu_unloaded` which runs on unload. These can be used to attach and clean up logic from systems.

### Commands

#### `load_menu <menu_name>`

Loads a specific menu, unloads the active menu if there is one. If you do not know which menus are available you can type `load_menu` and it will present a list.

#### `unload_menu`

Unloads the active menu if there is one.

### Demo Main Menu

The project name, and version numbers are pulled from ProjectSettings.

## Adding Menus

### MenuReference Resource

Menus are reference using `MenuReference` resources. `MenuManager` keeps a list of these. A `MenuReference` contains 2 fields, a name, and a path. This is basically just a way to make a typed dictionary in Godot 4.3, if you're using 4.4 I recommend updating this (if I haven't already).

The name is what you'll use in `MenuManager.load_menu(menu_name)` to reference the menu. The path should be to a scene with a `Menu`-derived node as its root.

### Adding Menu to MenuManager

Add a `MenuReference` to the `menus` list in `MenuManager`. It will get added on load. Then it can be loaded/unloaded.

## Localization

The demo main menu is already setup to integrate with my [Localization Package](https://github.com/WeekieNHN/GodotLocalizationPackage). The button texts will automatically get updated according to the translation files loaded in by the localization package.
