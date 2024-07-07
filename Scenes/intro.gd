extends Node2D

var intro_text := [
	"""You've slumbered for so long spirit.
We thought you gone.""",
	"""But here you be.""",
	"""The stain of <Boss name> runs thick in these woods.""",
	"""The strong of it's denizens have long since fled.
The lesser lie dead.""",
	"""But with you awake... Hope may yet be restored."""
]

@onready var text: RichTextLabel = %Text

func _ready() -> void:
	text.text = intro_text.pop_front()
	pass

func _input(event: InputEvent) -> void:
	if event.is_action("ui_accept") and !event.is_echo() and event.is_pressed():
		var new_text = intro_text.pop_front()
		if new_text:
			text.text = new_text
		else:
			SceneManager.show_level(1)
	pass
