extends Node2D

const base_space_width = 6
const base_char_width = 2 * base_space_width
const speed_wpm = 70

var running = true

@onready var TEST_TEXT_LABEL: RichTextLabel = $TestText
@onready var STAMINA_VALUE_LABEL: RichTextLabel = $StaminaValueLabel

@onready var stamina = 4:
	get():
		return stamina
	set(value):
		if value < 0:
			return value
		if value > 4:
			return value
		stamina = value
		STAMINA_VALUE_LABEL.text = str(value)
		return value

func _process(delta):
	if running:
		TEST_TEXT_LABEL.position.x -= (wpm_to_px(speed_wpm) * delta)
		if TEST_TEXT_LABEL.position.x <= 0:
			print('You lose')
			running = false
			TEST_TEXT_LABEL.position.x = 0
		pass

func _input(event: InputEvent) -> void:
	if event is InputEventKey and !event.is_echo() and event.is_pressed():
		var input_char = char(event.unicode).to_upper();
		var target_car = TEST_TEXT_LABEL.text.substr(0, 1).to_upper()
		
		if input_char == target_car:
			var new_text_raw = TEST_TEXT_LABEL.text.substr(1)
			var new_text = new_text_raw.strip_edges()
			if(new_text != new_text_raw):
				TEST_TEXT_LABEL.position.x += base_space_width
			TEST_TEXT_LABEL.position.x += base_char_width
			TEST_TEXT_LABEL.text = new_text
		else:
			stamina -= 1
		pass
	pass

func wpm_to_px(wpm: int):
	var px_per_second = (wpm * 5 * base_char_width) / 60
	return px_per_second

func _on_stamina_regen_timer_timeout() -> void:
	stamina += 1
	pass
