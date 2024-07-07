class_name WorldStats extends Resource

@export var current_level := 1
@export var player_x := 110.0
@export var player_face := 'right'

@export var last_grace_level := 1
@export var last_grace_x := 110.0
@export var last_grace_face := 'right'

@export var current_enemy_id := 0

@export var keys := {
    1: false,
    2: false,
}
@export var enemies := reset_enemies()

func reset_enemies() -> Dictionary:
    return {
        1: false,
        2: true,
        3: true,
        4: true,
        5: true,
        6: true,
        7: true,
    }