extends Node2D

@export var stats: Rock_stats
@onready var sprite = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var healthbar: ProgressBar = $Healthbar

var health = 20
@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var inventory = player.get_node('UI/CanvasLayer/AnimationPlayer/Inventory')


func _ready() -> void:
	sprite.texture = stats.texture
	healthbar.init_health(health)
	healthbar.hide()
	
#
func damage(attack: Attack):

	healthbar.show()
	health -= attack.attack_damage
	healthbar.health = health
	animation_player.play("hit_flash")
	if health < 0:
		inventory.add_item(stats.output)
		queue_free()
		return


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			var attack = Attack.new()
			attack.attack_damage = player.attack_damage
			damage(attack)
			
