class_name Player extends Node2D

@onready var sprite: Sprite2D = $Sprite2D

var world_stats: WorldStats = ResourceLoader.load("res://Resources/world_stats.tres")
var speed = 250

func _ready() -> void:
	global_position.x = world_stats.player_x
	face(world_stats.player_face)

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_left"):
		var new_pos = clampf(global_position.x - speed * delta, 0.0, 640.0)
		global_position.x = new_pos
		face('left')
		world_stats.player_x = global_position.x
		world_stats.player_face = 'left'
	if Input.is_action_pressed("ui_right"):
		var new_pos = clampf(global_position.x + speed * delta, 0.0, 640.0)
		global_position.x = new_pos
		face('right')
		world_stats.player_x = global_position.x
		world_stats.player_face = 'right'
	pass
	
func face(direction: String):
	if direction == 'left':
		sprite.flip_h = true
	if direction == 'right':
		sprite.flip_h = false