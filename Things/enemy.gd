class_name Enemy extends Node2D

@onready var sprite: Sprite2D = $Sprite2D

enum EnemySize { SMALL, MEDIUM, LARGE }
enum EnemyFacing { LEFT, RIGHT }

@export var size := EnemySize.SMALL
@export var facing := EnemyFacing.LEFT
@export var enemy_id := 0
@export var wpm := 70
@export var xp := 1
@export_multiline var text := "test"

var world_stats: WorldStats = preload("res://Resources/world_stats.tres")

func _ready() -> void:
	if size == EnemySize.SMALL:
		sprite.scale.x = 4
		sprite.scale.y = 4
	elif size == EnemySize.MEDIUM:
		sprite.scale.x = 6
		sprite.scale.y = 6
		sprite.offset.y -= 6
	else:
		sprite.scale.x = 8
		sprite.scale.y = 8
		sprite.offset.y -= 8
	if facing == EnemyFacing.LEFT:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
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
