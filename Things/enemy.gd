class_name Enemy extends Node2D

@export var enemy_id := 0

var world_stats: WorldStats = ResourceLoader.load("res://Resources/world_stats.tres")

func _ready() -> void:
	if world_stats.enemies.get(enemy_id):
		show()
	else:
		hide()

func _on_area_2d_area_entered(_area: Area2D) -> void:
	world_stats.current_enemy_id = enemy_id
	# SceneManager.start_typing_test()
	pass # Replace with function body.
