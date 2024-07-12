extends Node2D

@onready var level: RichTextLabel = %Level

var player_data: PlayerStats = preload("res://Resources/player_stats.tres")

func _ready() -> void:
    level.text = "[center]You were Level: " + str(player_data.level)