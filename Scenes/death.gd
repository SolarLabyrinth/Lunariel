extends Node2D

func _input(_event: InputEvent) -> void:
    if Input.is_action_just_pressed('sl_left_mouse'):
        SceneManager.go_back_to_previous_grace()