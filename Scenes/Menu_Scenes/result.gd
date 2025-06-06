extends Control

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var nine_patch_rect: NinePatchRect = $CanvasLayer/NinePatchRect
@onready var go_menu: Button = $CanvasLayer/NinePatchRect/VBoxContainer/go_menu
@onready var result_label: Label = $CanvasLayer/NinePatchRect/VBoxContainer/result_label
@onready var world_label: Label = $CanvasLayer/NinePatchRect/VBoxContainer/world_label


func _ready() -> void:
	var time : String = SceneManager.time
	var world_name : String = SceneManager.world_name
	
	if world_name == "":
		world_name = "World: Undefined"
	
	var minutes_ingame : int = SceneManager.minutes_ingame
	result_label.text = time
	world_label.text = world_name
	
	var save_path = "user://saveResults.json"
	var all_results : Array
	
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		var content = file.get_as_text()
		var parsed = JSON.parse_string(content)
		if parsed is Array:
			all_results = parsed
	
	all_results.append({
		"world_name": world_name,
		"world_time": time,
		"minutes_ingame": minutes_ingame
	})
	
	all_results.sort_custom(func(a, b): return a["minutes_ingame"] > b["minutes_ingame"])
	all_results = all_results.slice(0, 5)
	
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_string(JSON.stringify(all_results, "\t"))
	

func _on_go_menu_pressed() -> void:
	const BUTTON = preload("res://sounds/button.mp3")
	GlobalSFX.play(BUTTON)
	get_tree().change_scene_to_file("res://Scenes/Menu_Scenes/menu.tscn")
