extends Node2D

@export var player_data: PlayerStats = ResourceLoader.load("res://Resources/player_stats.tres")

@onready var speed_value: RichTextLabel = %SpeedValue
@onready var stamina_value: RichTextLabel = %StaminaValue
@onready var regen_value: RichTextLabel = %RegenValue
@onready var xp_value: RichTextLabel = %XPValue
@onready var levelvalue: RichTextLabel = %Levelvalue

func _ready() -> void:
	update_ui()
	player_data.changed.connect(update_ui)
	
func _exit_tree() -> void:
	player_data.changed.disconnect(update_ui)

func update_ui():
	speed_value.text = str(player_data.wpm_adjustment)
	stamina_value.text = str(player_data.stamina_amount)
	regen_value.text = str(player_data.stamina_regen)
	xp_value.text = str(player_data.xp)
	levelvalue.text = str(player_data.level)
	if player_data.xp >= player_data.wpm_adjustment:
		%SpeedAddButton.show()
		%SpeedSubButton.show()
	else:
		%SpeedAddButton.hide()
		%SpeedSubButton.hide()
	if player_data.xp >= player_data.stamina_amount:
		%StaminaAddButton.show()
		%StaminaSubButton.show()
	else:
		%StaminaAddButton.hide()
		%StaminaSubButton.hide()
	if player_data.xp >= player_data.stamina_regen:
		%RegenAddButton.show()
		%RegenSubButton.show()
	else:
		%RegenAddButton.hide()
		%RegenSubButton.hide()

func _on_speed_add_button_pressed() -> void:
	player_data.wpm_adjustment += 1

func _on_speed_sub_button_pressed() -> void:
	player_data.wpm_adjustment -= 1

func _on_stamina_add_button_pressed() -> void:
	player_data.stamina_amount += 1

func _on_stamina_sub_button_pressed() -> void:
	player_data.stamina_amount -= 1

func _on_regen_add_button_pressed() -> void:
	player_data.stamina_regen += 1

func _on_regen_sub_button_pressed() -> void:
	player_data.stamina_regen -= 1

func _on_add_xp_button_pressed() -> void:
	player_data.xp += 1


func _on_add_xp_button_2_pressed() -> void:
	SceneManager.start_typing_test()
	pass # Replace with function body.
