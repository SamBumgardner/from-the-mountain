extends Node

signal new_generation_begins

var map_state_preload : PackedScene = preload("res://map/map.tscn")
var legacy_state_preload : PackedScene = preload("res://end_screen/character_legacy.tscn")

var map_state : MapScene
var legacy_state : CharacterLegacy

func _ready():
	map_state = map_state_preload.instantiate()
	legacy_state = legacy_state_preload.instantiate()
	add_child(map_state)
	
	map_state.character_finished.connect(_on_character_finished)
	legacy_state.legacy_screen_finished.connect(_on_legacy_screen_finished)
	new_generation_begins.connect(map_state._on_new_generation_begins)

func _on_character_finished(finished_character:Player):
	map_state.process_mode = Node.PROCESS_MODE_DISABLED
	add_child(legacy_state)

func _on_legacy_screen_finished():
	new_generation_begins.emit()
	remove_child(legacy_state)
	map_state.process_mode = Node.PROCESS_MODE_INHERIT
