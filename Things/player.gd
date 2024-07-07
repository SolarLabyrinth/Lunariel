class_name Player extends Node2D

@onready var sprite: Sprite2D = $Sprite2D

var world_stats: WorldStats = ResourceLoader.load("res://Resources/world_stats.tres")
var speed = 250

func _ready() -> void:
	global_position.x = world_stats.player_x
	face(world_stats.player_face)

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_left"):
		global_position.x -= speed * delta
		face('left')
		world_stats.player_x = global_position.x
		world_stats.player_face = 'left'
	if Input.is_action_pressed("ui_right"):
		global_position.x += speed * delta
		face('right')
		world_stats.player_x = global_position.x
		world_stats.player_face = 'right'
	pass
	
func face(direction: String):
	if direction == 'left':
		sprite.flip_h = true
	if direction == 'right':
		sprite.flip_h = false