extends Control


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu_Scenes/menu.tscn")



func _on_create_pressed() -> void:
	var world_name : String = $NinePatchRect/MarginContainer/VBoxContainer/LineEdit.text
	SceneManager.create_game(world_name)
	
