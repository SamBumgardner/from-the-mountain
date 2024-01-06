extends ProgressBar

func _ready():
	$EnergySpendParticle.global_position.x = global_position.x + (size.x / 2.0)

func _on_value_changed(value):
	var top_of_fill = global_position.y + size.y - (size.y * value / max_value)
	$EnergySpendParticle.global_position.y = top_of_fill
	
	$EnergySpendParticle.restart()


func _on_player_energy_changed(new_value):
	value = new_value
