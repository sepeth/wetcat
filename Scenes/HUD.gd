extends CanvasLayer

const bar_red = preload("res://Images/ProgressBar/red.png")
const bar_green = preload("res://Images/ProgressBar/green.png")
const bar_orange = preload("res://Images/ProgressBar/orange.png")


func update_healthbar(value):
	var hunger_bar = $Health/HungerBar
	hunger_bar.texture_progress = bar_green
	if value < hunger_bar.max_value * 0.7:
		hunger_bar.texture_progress = bar_orange
	if value < hunger_bar.max_value * 0.35:
		hunger_bar.texture_progress = bar_red
	hunger_bar.value = value


func _on_player_health_changed(value):
	update_healthbar(value)
