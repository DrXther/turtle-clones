extends Node2D

func _ready() -> void:
	if PlayerResorces.loaded:
		PlayerResorces.load_game()
	else:
		PlayerResorces.change_money(250)


func _on_button_pressed() -> void:
	PlayerResorces.save_game()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
