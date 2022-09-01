extends CanvasLayer

signal cat_died

const bar_red = preload("res://Images/ProgressBar/red.png")
const bar_green = preload("res://Images/ProgressBar/green.png")
const bar_orange = preload("res://Images/ProgressBar/orange.png")

@onready var health = $HungerBar.max_value :
	set(value):
		health = value
		if health <= 0:
			emit_signal("cat_died")
		update_healthbar(health)


func _ready():
	update_healthbar(health)


func _on_hunger_timer_timeout():
	health -= 1


func _on_player_ate_fish():
	health += 5


func update_healthbar(value):
	$HungerBar.texture_progress = bar_green
	if value < $HungerBar.max_value * 0.7:
		$HungerBar.texture_progress = bar_orange
	if value < $HungerBar.max_value * 0.35:
		$HungerBar.texture_progress = bar_red
	$HungerBar.value = value
