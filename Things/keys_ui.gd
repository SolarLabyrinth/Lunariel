extends Node2D

@onready var key1 = %Key1
@onready var key2 = %Key2

var world_stats: WorldStats = preload("res://Resources/world_stats.tres")

func _ready() -> void:
    set_keys()
    world_stats.keys_changed.connect(set_keys)

func _exit_tree() -> void:
    world_stats.keys_changed.disconnect(set_keys)

func set_keys() -> void:
    if world_stats.keys[1]:
        key1.frame = 1
    else:
        key1.frame = 0
    if world_stats.keys[2]:
        key2.frame = 1
    else:
        key2.frame = 0
