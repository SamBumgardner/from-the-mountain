class_name MapScene extends Node2D

signal start_end_of_game_sequence(reason:String)
signal character_finished(player:Player)

var player_start_position:Vector2i = Vector2i(2, 2)

func _ready():
	pass

func _on_new_generation_begins():
	# do all of the logic needed to reset & progress the world
	$Player.force_change_position(Vector2i(2,2))
	$Player.restart()
	pass

func _on_player_character_finished(this_player):
	character_finished.emit(this_player)

func _on_player_start_end_of_game_sequence(reason:String):
	start_end_of_game_sequence.emit(reason)
