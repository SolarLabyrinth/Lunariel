class_name Key extends Node2D

@export var key_id := 0

var world_stats: WorldStats = preload("res://Resources/world_stats.tres")

func _ready() -> void:
	if world_stats.keys[key_id]:
		queue_free()

func _on_area_2d_area_entered(_area:Area2D) -> void:
	world_stats.keys[key_id] = true
	world_stats.keys_changed.emit()
	hide()
	await SceneManager.play_pickup_key()
	queue_free()
