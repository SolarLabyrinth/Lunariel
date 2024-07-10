extends Node2D

var player_data: PlayerStats = preload("res://Resources/player_stats.tres")

@export var words_per_minute = 70
@export var text = "By ancient light and purest flame, From shadow's grasp, I reclaim. Spirits of earth, air, water, and fire, Cleanse this place, lift the dire. From roots to leaves, night shall flee, Restore this forest, blessed be. Darkness gone, light’s embrace, Peace and life, now take their place."

const SCALE = 2
const base_space_width = 3 * SCALE
const base_char_width = 2 * 3 * SCALE

var running = true

@onready var TEST_TEXT_LABEL: RichTextLabel = %TestText
@onready var STAMINA_VALUE_LABEL: RichTextLabel = %StaminaValueLabel
@onready var WPM_VALUE_LABEL: RichTextLabel = %WPMValueLabel

@onready var stamina = player_data.stamina_amount + 3:
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

func get_wpm():
	return words_per_minute - (player_data.wpm_adjustment - 1) * 3

func _ready() -> void:
	TEST_TEXT_LABEL.text = text
	WPM_VALUE_LABEL.text = str(get_wpm())

func _process(delta):
	if running:
		TEST_TEXT_LABEL.position.x -= (wpm_to_px(get_wpm()) * delta)
		if TEST_TEXT_LABEL.position.x <= 0:
			print('You lose')
			running = false
			TEST_TEXT_LABEL.position.x = 0
		pass

func _input(event: InputEvent) -> void:
	if event is InputEventKey and !event.is_echo() and event.is_pressed():
		var input_char = char(event.unicode).to_upper();
		var target_car = TEST_TEXT_LABEL.text.substr(0, 1).to_upper()
		
		var is_correct_char = input_char == target_car
		if !is_correct_char and stamina > 0:
			stamina -= 1
			is_correct_char = true
		
		if is_correct_char:
			var new_text_raw = TEST_TEXT_LABEL.text.substr(1)
			var new_text = new_text_raw.strip_edges()
			if(new_text != new_text_raw):
				TEST_TEXT_LABEL.position.x += base_space_width - 1
			TEST_TEXT_LABEL.position.x += base_char_width
			TEST_TEXT_LABEL.text = new_text
		pass
	pass

func wpm_to_px(wpm: int):
	var px_per_second = (wpm * 5.0 * base_char_width) / 60.0
	return px_per_second

func _on_stamina_regen_timer_timeout() -> void:
	stamina += 1
	pass
