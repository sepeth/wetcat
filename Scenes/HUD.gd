extends CanvasLayer


func update_healthbar(value):
	var health_bar = $Health/HealthBar
	health_bar.value = value


func _on_player_health_changed(value):
	update_healthbar(value)
