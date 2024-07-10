extends Node2D

@onready var rich_text_label: RichTextLabel = %TestText
@onready var STAMINA_VALUE_LABEL: RichTextLabel = %StaminaValueLabel
@onready var time_remaining_value: RichTextLabel = %TimeRemainingValue
@onready var hourglass: AnimatedSprite2D = %Hourglass
@onready var staminabar: AnimatedSprite2D = %StaminaBar

var player_data: PlayerStats = ResourceLoader.load("res://Resources/player_stats.tres")
var world_stats: WorldStats = ResourceLoader.load("res://Resources/world_stats.tres")

var wpm := world_stats.current_wpm
var xp_value := world_stats.current_xp
var test_text := world_stats.current_text

var running := false
var already_typed := ""
var left_to_type := test_text
var time_remaining = 10000000.0
var total_time = time_remaining

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
		staminabar.frame = stamina
		return stamina
		
func calc_test_time():
	return 60.0 * (test_text.length() / 5.0 / wpm) + 1
func set_time_display(value: float):
	time_remaining_value.text = str(floor(value))
func set_hourglass_frame():
	var num_frames: int = hourglass.sprite_frames.get_frame_count('default')
	var progress: float = 1.0 - time_remaining / total_time
	var active_frame = floor(progress * num_frames)
	hourglass.frame = active_frame

func _ready() -> void:
	time_remaining = calc_test_time()
	total_time = time_remaining
	set_hourglass_frame()
	set_time_display(time_remaining)
	rich_text_label.text = test_text
	left_to_type = test_text
	staminabar.frame = stamina
	pass

func _process(delta: float) -> void:
	if running:
		time_remaining -= delta
		set_hourglass_frame()
		set_time_display(time_remaining)
	if time_remaining <= 0:
		SceneManager.go_back_to_previous_grace()
		world_stats.reset_enemies()

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
			world_stats.enemies[world_stats.current_enemy_id] = false
			player_data.xp += xp_value
			SceneManager.go_back_to_previous_level()
	pass

func _on_stamina_regen_timer_timeout() -> void:
	stamina += 1
