class_name Inventory extends RefCounted

signal resource_count_updated(resource_changes:Array[InvResource])

var resource_array:Array[int] = [0,0,0]

enum {WOOD, STONE, FOOD}

func update_resource_count(resource_changes: Array[InvResource]):
	for change in resource_changes:
		resource_array[change.type] += change.amount
	
	resource_count_updated.emit(resource_array)

func get_resource_amounts():
	return resource_array

class InvResource:
	var type:int
	var amount:int
