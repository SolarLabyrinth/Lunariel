extends Node2D

@onready var player: Player = $Player
@onready var grace: Grace = $Grace

var world_stats: WorldStats = ResourceLoader.load("res://Resources/world_stats.tres")
var speed = 200


func _ready() -> void:
	player.global_position.x = world_stats.player_x
	player.face(world_stats.player_face)

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_left"):
		player.global_position.x -= speed * delta
		player.face('left')
		world_stats.player_x = player.global_position.x
		world_stats.player_face = 'left'
	if Input.is_action_pressed("ui_right"):
		player.global_position.x += speed * delta
		player.face('right')
		world_stats.player_x = player.global_position.x
		world_stats.player_face = 'right'
	if Input.is_action_just_pressed('sl_interact') and world_stats.at_grace:
		world_stats.current_level = grace.level_id
		world_stats.player_x = player.global_position.x
		SceneManager.show_stats_screen()
	if Input.is_action_just_pressed('sl_interact') and world_stats.at_door:
		#world_stats.current_level = grace.level_id
		#world_stats.player_x = player.global_position.x
		#SceneManager.show_stats_screen()
		pass
	pass
