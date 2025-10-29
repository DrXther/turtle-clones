extends Control

@onready var button_continue = $MarginContainer/VBoxContainer/Button_Continue
@onready var button_newgame = $MarginContainer/VBoxContainer/Button_NewGame
@onready var button_exit = $MarginContainer/VBoxContainer/Button_Exit

const SAVE_PATH := "user://savegame.json"

func _ready() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		button_continue.disabled = false
	else:
		button_continue.disabled = true
	
	button_continue.pressed.connect(_on_continue_pressed)
	button_newgame.pressed.connect(_on_new_game_pressed)
	button_exit.pressed.connect(_on_exit_pressed)

func _on_continue_pressed() -> void:
	PlayerResorces.loaded = true
	get_tree().change_scene_to_file("res://scenes/tree_plantation.tscn")

func _on_new_game_pressed() -> void:
	# TODO: Skasuj stary save jeśli istnieje
	if FileAccess.file_exists(SAVE_PATH):
		DirAccess.remove_absolute(ProjectSettings.globalize_path(SAVE_PATH))
	get_tree().change_scene_to_file("res://scenes/tree_plantation.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
