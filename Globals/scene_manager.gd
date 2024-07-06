extends Node2D

const TYPING_TEST = preload("res://Scenes/TypingTest2.tscn")
const STATS_SCREEN = preload("res://Scenes/StatsScreen.tscn")

func start_typing_test() -> void:
	get_tree().change_scene_to_packed(TYPING_TEST)
func show_stats_screen() -> void:
	get_tree().change_scene_to_packed(STATS_SCREEN)
