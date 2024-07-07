class_name Grace extends Node2D

@export var level_id := 0

var world_stats: WorldStats = ResourceLoader.load("res://Resources/world_stats.tres")

@onready var interaction_label: RichTextLabel = %InteractionLabel

func _on_area_2d_area_entered(area: Area2D) -> void:
	world_stats.at_door = true
	interaction_label.show()

func _on_area_2d_area_exited(area: Area2D) -> void:
	world_stats.at_door = true
	interaction_label.hide()
