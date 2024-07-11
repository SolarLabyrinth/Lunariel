extends Node2D

var player_data: PlayerStats = preload("res://Resources/player_stats.tres")
var world_stats: WorldStats = preload("res://Resources/world_stats.tres")

@export var level_id := 0

func _ready() -> void:
    if world_stats.last_xp_level == level_id and world_stats.last_xp_value != 0:
        position.x = world_stats.last_xp_x
    else:
        hide()
        queue_free()

func _on_area_2d_area_entered(_area:Area2D) -> void:
    player_data.xp += world_stats.last_xp_value

    world_stats.last_xp_level = 0
    world_stats.last_xp_value = 0
    world_stats.last_xp_x = 0

    hide()
    await SceneManager.play_pickup_key()
    queue_free()
