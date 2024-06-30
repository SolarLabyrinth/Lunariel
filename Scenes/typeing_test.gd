extends Node2D

@export var words_per_minute = 50
@export var text = "porttitor lacus luctus accumsan tortor posuere ac ut consequat semper viverra nam libero justo laoreet sit amet cursus sit amet dictum sit amet justo donec enim diam vulputate ut pharetra sit amet aliquam id diam maecenas ultricies mi eget mauris pharetra et ultrices neque ornare aenean euismod elementum nisi quis eleifend quam adipiscing vitae proin sagittis nisl rhoncus mattis rhoncus urna neque viverra justo nec ultrices dui sapien eget mi"

const base_space_width = 6
const base_char_width = 2 * base_space_width

var running = true

@onready var TEST_TEXT_LABEL: RichTextLabel = $TestText
@onready var STAMINA_VALUE_LABEL: RichTextLabel = $StaminaValueLabel
@onready var WPM_VALUE_LABEL: RichTextLabel = $WPMValue

@onready var stamina = 4:
	get():
		return stamina
	set(value):
		if value < 0:
			stamina = 0
		elif value > 4:
			stamina = 4
		else:
			stamina = value
		STAMINA_VALUE_LABEL.text = str(stamina)
		return stamina

func _ready() -> void:
	TEST_TEXT_LABEL.text = text
	WPM_VALUE_LABEL.text = str(words_per_minute)

func _process(delta):
	if running:
		TEST_TEXT_LABEL.position.x -= (wpm_to_px(words_per_minute) * delta)
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
