class_name Enemy extends Node2D

@export var enemy_id := 0
@export var wpm := 70
@export var xp := 1
@export_multiline var text := "test"

var world_stats: WorldStats = ResourceLoader.load("res://Resources/world_stats.tres")

func _ready() -> void:
	if world_stats.enemies.get(enemy_id):
		show()
	else:
		hide()

func _on_area_2d_area_entered(_area: Area2D) -> void:
	if world_stats.enemies.get(enemy_id):
		world_stats.current_enemy_id = enemy_id
		world_stats.current_wpm = wpm
		world_stats.current_xp = xp
		world_stats.current_text = text
		SceneManager.start_typing_test()
