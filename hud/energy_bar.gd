extends ProgressBar

var old_value:float;

func _ready():
	$EnergySpendParticle.global_position.x = global_position.x + (size.x / 2.0)
	old_value = value

func _on_value_changed(value):
	var top_of_fill = global_position.y + size.y - (size.y * value / max_value)
	$EnergySpendParticle.global_position.y = top_of_fill
	var particle_count:int = int(old_value - value)
	if particle_count > 0:
		$EnergySpendParticle.amount =  particle_count
		$EnergySpendParticle.restart()
	
	old_value = value


func _on_player_energy_changed(new_value):
	value = new_value
