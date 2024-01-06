extends Sprite2D

@export var color : Color = Color.LIGHT_BLUE
@export var amount_remaining : float = 1
@export var tile_text : String = ""

func _ready():
	material = material.duplicate()
	set_remaining(amount_remaining)
	set_color(color)
	$label.text = tile_text

func set_remaining(fraction_remaining:float) -> void:
	material.set_shader_parameter("remaining", fraction_remaining)

func set_color(new_color:Color) -> void:
	modulate = new_color
	material.set_shader_parameter("mod_color", new_color)
