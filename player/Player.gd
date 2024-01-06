extends Sprite2D

@export var world_map : WorldMap;

var current_coords : Vector2i;

func _ready():
	current_coords = world_map.local_to_map(world_map.to_local(global_position))
	
	pass

func move(distance : Vector2i):
	var tile : Tile = world_map.get_tile(current_coords + distance)
	print(tile)
	# decide if player successfully moves
	global_position = tile.global_position
	
	current_coords = current_coords + distance

func _input(event):
	if event.is_action_pressed("player_left"):
		move(Vector2i(-1, 0))
	if event.is_action_pressed("player_right"):
		move(Vector2i(1, 0))
	if event.is_action_pressed("player_down"):
		move(Vector2i(0,1))
	if event.is_action_pressed("player_up"):
		move(Vector2i(0,-1))
