extends Node2D

@export var player_data: PlayerStats

@onready var speed_value: RichTextLabel = %SpeedValue
@onready var stamina_value: RichTextLabel = %StaminaValue
@onready var regen_value: RichTextLabel = %RegenValue

func _ready() -> void:
	player_data.changed.connect(_on_state_changed)
	pass

func _on_speed_add_button_pressed() -> void:
	player_data.wpm_adjustment += 1
	pass # Replace with function body.

func _on_speed_sub_button_pressed() -> void:
	player_data.wpm_adjustment -= 1
	pass # Replace with function body.

func _on_state_changed():
	speed_value.text = str(player_data.wpm_adjustment)
	stamina_value.text = str(player_data.stamina_amount)
	regen_value.text = str(player_data.stamina_regen)
	pass
