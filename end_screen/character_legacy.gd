class_name CharacterLegacy extends TextureRect

signal legacy_screen_finished

func _input(event):
	if event.is_action_pressed("player_interact"):
		legacy_screen_finished.emit()
