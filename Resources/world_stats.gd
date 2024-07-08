class_name WorldStats extends Resource

@export var current_level := 1
@export var player_x := 110.0
@export var player_face := 'right'

@export var last_grace_level := current_level
@export var last_grace_x := player_x
@export var last_grace_face := player_face

@export var current_enemy_id := 0

@export var keys := {
    1: false,
    2: false,
}
@export var enemies := generate_enemies()

func generate_enemies() -> Dictionary:
    return {
        1: true,
        2: true,
        3: true,
        4: true,
        5: true,
        6: true,
        7: true,
    }
func reset_enemies():
    enemies = generate_enemies()