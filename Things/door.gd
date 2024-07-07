class_name Door extends Node2D

@onready var interaction_label: RichTextLabel = %InteractionLabel

var world_stats: WorldStats = ResourceLoader.load("res://Resources/world_stats.tres")

@export var target_level_id := 0
@export var target_player_x := 0
@export var target_player_face := 0

func _on_area_2d_area_entered(area: Area2D) -> void:
	world_stats.at_grace = true
	interaction_label.show()

func _on_area_2d_area_exited(area: Area2D) -> void:
	world_stats.at_grace = true
	interaction_label.hide()
