class_name PlayerStats extends Resource

@export var stamina_regen := 0:
	set(value):
		stamina_regen = value
		changed.emit()
		
@export var stamina_amount := 0:
	set(value):
		stamina_amount = value
		changed.emit()
		
@export var wpm_adjustment := 0:
	set(value):
		wpm_adjustment = value
		changed.emit()
