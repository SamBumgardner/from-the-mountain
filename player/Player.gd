class_name Player extends Sprite2D

signal energy_changed(new_value:float)
signal character_finished(this_player:Player)

const MAX_ENERGY : float = 100

@export var world_map : WorldMap;

var current_coords : Vector2i;
var current_energy : float = MAX_ENERGY :
	set(value):
		current_energy = value
		energy_changed.emit(current_energy)

func _ready():
	current_coords = world_map.local_to_map(world_map.to_local(global_position))
	pass

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
		
		if current_energy <= 0:
			print("character is exhuasted! end game now")
			character_finished.emit(self)

func _input(event):
	if event.is_action_pressed("player_left"):
		move(Vector2i(-1, 0))
	if event.is_action_pressed("player_right"):
		move(Vector2i(1, 0))
	if event.is_action_pressed("player_down"):
		move(Vector2i(0,1))
	if event.is_action_pressed("player_up"):
		move(Vector2i(0,-1))
