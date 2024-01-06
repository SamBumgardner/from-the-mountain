class_name Player extends Sprite2D

signal energy_changed(new_value:float)
signal start_end_of_game_sequence(reason:String)
signal character_finished(this_player:Player)

const MAX_ENERGY : float = 100

@export var world_map : WorldMap;

var current_coords : Vector2i;
var current_energy : float = MAX_ENERGY :
	set(value):
		current_energy = value
		energy_changed.emit(current_energy)

var _game_ending : bool = false

func _ready():
	current_coords = world_map.local_to_map(world_map.to_local(global_position))
	pass

func restart():
	_game_ending = false
	current_energy = MAX_ENERGY

func force_change_position(coordinates : Vector2i):
	var tile : Tile = world_map.get_tile(coordinates)
	if tile != null:
		global_position = tile.global_position
		current_coords = coordinates

func move(distance : Vector2i):
	var tile : Tile = world_map.get_tile(current_coords + distance)

	if tile != null:
		if current_energy > 0:
			current_energy -= tile.movement_in_cost
			global_position = tile.global_position
			current_coords = current_coords + distance
			#resolve any additional results of moving into tile.
		
		if current_energy <= 0 and not _game_ending:
			print("character is exhuasted! Start end-of-game process now")
			start_end_of_game_sequence.emit("energy")
			$GameEndDelay.start()
			_game_ending = true

func _input(event):
	if event.is_action_pressed("player_left"):
		move(Vector2i(-1, 0))
	if event.is_action_pressed("player_right"):
		move(Vector2i(1, 0))
	if event.is_action_pressed("player_down"):
		move(Vector2i(0,1))
	if event.is_action_pressed("player_up"):
		move(Vector2i(0,-1))

func _on_game_end_delay_timeout():
	character_finished.emit(self)
