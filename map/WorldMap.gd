class_name WorldMap extends TileMap

signal new_generation_begins

func _ready():
	pass

func get_tile(requested_coords : Vector2i) -> Tile:
	var child_index: int = get_cell_alternative_tile(0, requested_coords)
	if child_index >= 0:
		return get_child(child_index)
	else:
		return null

func _on_child_entered_tree(child):
	var child_coord: Vector2i = local_to_map(to_local(child.global_position))
	set_cell(0, child_coord, 0, Vector2i.ZERO, child.get_index())
	new_generation_begins.connect(child._on_new_generation_begins)

func _on_child_exiting_tree(node):
	print("losing a child!")
	pass # Replace with function body.
