class_name Tile extends Sprite2D

@export var color : Color = Color.LIGHT_BLUE
@export var generation_recovery : float = .5
@export var amount_remaining : float = 1
@export var tile_text : String = ""
@export var movement_in_cost : float = 20.0
@export var harvest_cost : float = 5.0
@export var resource_yield : Array[int] = [0, 0, 0]

func _ready():
	material = material.duplicate()
	set_remaining(amount_remaining)
	set_color(color)
	$label.text = tile_text

func set_remaining(fraction_remaining:float) -> void:
	amount_remaining = fraction_remaining
	material.set_shader_parameter("remaining", fraction_remaining)

func set_color(new_color:Color) -> void:
	modulate = new_color
	material.set_shader_parameter("mod_color", new_color)

func can_harvest() -> bool:
	return amount_remaining >= 1

func harvest() -> Array[Inventory.InvResource]:
	# should return something more complex in the future - inner class for harvest reward?
	var harvested_amount = amount_remaining
	set_remaining(0)
	
	var harvest_results:Array[Inventory.InvResource] = []
	for i in resource_yield.size():
		var harvest_result = Inventory.InvResource.new()
		harvest_result.type = i
		harvest_result.amount = resource_yield[i]
		harvest_results.append(harvest_result)
		
	return harvest_results

func _on_new_generation_begins():
	set_remaining(min(1, amount_remaining + generation_recovery))
