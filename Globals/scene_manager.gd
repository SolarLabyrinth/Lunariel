extends Node2D

var world_stats: WorldStats = preload("res://Resources/world_stats.tres")

const TYPING_TEST = preload("res://Scenes/TypingTest2.tscn")
const STATS_SCREEN = preload("res://Scenes/StatsScreen.tscn")
const INTRO = preload("res://Scenes/Intro.tscn")

const WIN = preload("res://Scenes/Win.tscn")
const DEATH = preload("res://Scenes/Death.tscn")

const levels = [
	preload("res://Scenes/Levels/Level1.tscn"),
	preload("res://Scenes/Levels/Level2.tscn"),
	preload("res://Scenes/Levels/Level3.tscn"),
	preload("res://Scenes/Levels/Level4.tscn"),
	preload("res://Scenes/Levels/Level5.tscn"),
	preload("res://Scenes/Levels/Level6.tscn"),
	preload("res://Scenes/Levels/Level7.tscn"),
	preload("res://Scenes/Levels/Level8.tscn"),
]

func start_typing_test() -> void:
	get_tree().change_scene_to_packed(TYPING_TEST)
func show_stats_screen() -> void:
	get_tree().change_scene_to_packed(STATS_SCREEN)
func play_intro() -> void:
	get_tree().change_scene_to_packed(INTRO)

func show_win() -> void:
	get_tree().change_scene_to_packed(WIN)
func show_death() -> void:
	get_tree().change_scene_to_packed(DEATH)

func show_level(level: int) -> void:
	if(level >= 1 and level <= levels.size()):
		world_stats.current_level = level
		get_tree().change_scene_to_packed(levels[level-1])

func go_back_to_previous_level() -> void:
	get_tree().change_scene_to_packed(levels[world_stats.current_level-1])

func go_back_to_previous_grace() -> void:
	world_stats.current_level = world_stats.last_grace_level
	world_stats.player_x = world_stats.last_grace_x
	world_stats.player_face = world_stats.last_grace_face
	get_tree().change_scene_to_packed(levels[world_stats.current_level-1])

@onready var key_player: AudioStreamPlayer = %KeyPickup
@onready var click_player: AudioStreamPlayer = %Click

func play_pickup_key():
	if !key_player.playing:
		key_player.play()
	return key_player.finished

func play_click():
	# if !click_player.playing:
	# 	click_player.play()
	# return click_player.finished
	pass