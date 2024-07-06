class_name PlayerStats extends Resource

@export var level := 1:
	get():
		return 1 + (stamina_regen - 1) + (stamina_amount - 1) + (wpm_adjustment - 1)

@export var xp := 0:
	set(value):
		var newValue = clamp(value, 0, 999)
		if newValue != xp:
			xp = value
			changed.emit()

@export var stamina_regen := 1:
	set(value):
		if xp < stamina_regen:
			return stamina_regen
		xp -= stamina_regen
		var newValue = clamp(value, 1, 9)
		if newValue != stamina_regen:
			stamina_regen = value
			changed.emit()
		
@export var stamina_amount := 1:
	set(value):
		if xp < stamina_amount:
			return stamina_amount
		xp -= stamina_amount
		var newValue = clamp(value, 1, 9)
		if newValue != stamina_amount:
			stamina_amount = value
			changed.emit()
		
@export var wpm_adjustment := 1:
	set(value):
		if xp < wpm_adjustment:
			return wpm_adjustment
		xp -= wpm_adjustment
		var newValue = clamp(value, 1, 9)
		if newValue != wpm_adjustment:
			wpm_adjustment = value
			changed.emit()

@export var test_wpm := 70
@export var test_xp_value := 1
@export var test_text := """test"""
#@export var test_text := """By ancient light and purest flame,
#From shadow's grasp, I reclaim.
#Spirits of earth, air, water, and fire,
#Cleanse this place, lift the dire.
#From roots to leaves, night shall flee,
#Restore this forest, blessed be.
#Darkness gone, light’s embrace,
#Peace and life, now take their place."""
