class_name Grace extends Node2D

@export var level_id := 0

@onready var interaction_label: RichTextLabel = %InteractionLabel

var world_stats: WorldStats = ResourceLoader.load("res://Resources/world_stats.tres")

var is_active := false:
	set(value):
		is_active = value
		if is_active:
			interaction_label.show()
		else:
			interaction_label.hide()
		return is_active

func _on_area_2d_area_entered(_area: Area2D) -> void:
	is_active = true

func _on_area_2d_area_exited(_area: Area2D) -> void:
	is_active = false

func _input(_event: InputEvent) -> void:
	if is_active and Input.is_action_just_pressed('sl_interact'):
		world_stats.current_level = level_id
		SceneManager.show_stats_screen()
	pass
