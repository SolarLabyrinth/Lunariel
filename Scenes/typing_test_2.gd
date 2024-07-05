extends Node2D

@onready var rich_text_label: RichTextLabel = %TestText
@onready var STAMINA_VALUE_LABEL: RichTextLabel = %StaminaValueLabel
@onready var time_remaining_value: RichTextLabel = %TimeRemainingValue

@export var player_data: PlayerStats
@export var wpm := 70
@export var xp_value := 1
@export_multiline var test_text := ''

signal test_over(success: bool)

var running := false
var already_typed := ""
var left_to_type := test_text
var time_remaining = 10000000.0

@onready var stamina := player_data.stamina_amount + 3:
	get():
		return stamina
	set(value):
		if value < 0:
			stamina = 0
		elif value > player_data.stamina_amount + 3:
			stamina = player_data.stamina_amount + 3
		else:
			stamina = value
		STAMINA_VALUE_LABEL.text = str(stamina)
		return stamina
		
func calc_test_time():
	return 60.0 * (test_text.length() / 5.0 / wpm) + 1
func set_time_display(value: float):
	time_remaining_value.text = str(floor(value))

func _ready() -> void:
	time_remaining = calc_test_time()
	set_time_display(time_remaining)
	rich_text_label.text = test_text
	left_to_type = test_text
	pass

func _process(delta: float) -> void:
	if running:
		time_remaining -= delta
		set_time_display(time_remaining)
	if time_remaining <= 0:
		test_over.emit(false)

var characters_to_type = "ABCDEFGHIJKLMNOPQRSTUVWXYZ'.,".split("", true, 0)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and !event.is_echo() and event.is_pressed():
		var input_char = char(event.unicode).to_upper();
		if !characters_to_type.has(input_char):
			return
		
		var target_car = left_to_type.substr(0, 1).to_upper()
		while !characters_to_type.has(target_car):
			already_typed += target_car
			left_to_type = left_to_type.substr(1)
			target_car = left_to_type.substr(0, 1).to_upper()
			var prefix = "[color=#222323]" + already_typed + "[/color]" + left_to_type
			rich_text_label.text = prefix
		
		var is_correct_char = input_char == target_car
		if !is_correct_char and stamina > 0:
			stamina -= 1
			is_correct_char = true
		
		if is_correct_char:
			running = true
			#var new_text = new_text_raw.strip_edges()
			already_typed += target_car
			left_to_type = left_to_type.substr(1)
			var prefix = "[color=#222323]" + already_typed + "[/color]" + left_to_type
			rich_text_label.text = prefix
		
		if left_to_type.length() <= 0:
			running = false
			test_over.emit(true)
	pass

func _on_stamina_regen_timer_timeout() -> void:
	stamina += 1
