extends CanvasLayer

const bar_red = preload("res://Images/ProgressBar/red.png")
const bar_green = preload("res://Images/ProgressBar/green.png")
const bar_orange = preload("res://Images/ProgressBar/orange.png")


func update_healthbar(value):
	$HungerBar.texture_progress = bar_green
	if value < $HungerBar.max_value * 0.7:
		$HungerBar.texture_progress = bar_orange
	if value < $HungerBar.max_value * 0.35:
		$HungerBar.texture_progress = bar_red
	$HungerBar.value = value


func _on_player_health_changed(value):
	update_healthbar(value)
