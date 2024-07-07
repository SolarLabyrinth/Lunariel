class_name Player
extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D

func face(direction: String):
	if direction == 'left':
		sprite_2d.flip_h = true
	if direction == 'right':
		sprite_2d.flip_h = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body)
	pass # Replace with function body.
