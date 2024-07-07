class_name Door extends Node2D

@export var target_level_id := 0
@export var target_player_x := 0
@export var target_player_face := 0
@export var lock := 0

@onready var interaction_label: RichTextLabel = %InteractionLabel
@onready var lock_sprite: Sprite2D = %Lock

var world_stats: WorldStats = ResourceLoader.load("res://Resources/world_stats.tres")

var is_activatable := false:
	set(value):
		is_activatable = value
		if is_activatable:
			interaction_label.show()
		else:
			interaction_label.hide()
		return is_activatable
var is_lock_active := false:
	set(value):
		is_lock_active = value
		if is_lock_active:
			lock_sprite.show()
		else:
			lock_sprite.hide()
		return is_lock_active

func _on_area_2d_area_entered(_area: Area2D) -> void:
	if lock == 0:
		is_activatable = true
	elif !world_stats.keys[lock]:
		is_lock_active = true

func _on_area_2d_area_exited(_area: Area2D) -> void:
	is_activatable = false
	is_lock_active = false

func _input(_event: InputEvent) -> void:
	if is_activatable and Input.is_action_just_pressed('sl_interact'):
		SceneManager.show_level(target_level_id)
		pass
	pass
