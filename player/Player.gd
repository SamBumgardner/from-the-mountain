extends Sprite2D

signal energy_changed(new_value:float)

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

func move(distance : Vector2i):
	var tile : Tile = world_map.get_tile(current_coords + distance)

	if tile != null:
		# Check if player has enough energy
		if current_energy > 0:
			current_energy -= tile.movement_in_cost
			# move player to found tile
			global_position = tile.global_position
			current_coords = current_coords + distance
		
		if current_energy <= 0:
			print("character is exhuasted! end game now")

func _input(event):
	if event.is_action_pressed("player_left"):
		move(Vector2i(-1, 0))
	if event.is_action_pressed("player_right"):
		move(Vector2i(1, 0))
	if event.is_action_pressed("player_down"):
		move(Vector2i(0,1))
	if event.is_action_pressed("player_up"):
		move(Vector2i(0,-1))
