extends CharacterBody2D

signal starved
signal health_changed(health)

@export var speed = 100
@export var float_factor_x = 0.5

const MAX_HEALTH = 15

var health :
	set(value):
		health = clamp(value, 0, MAX_HEALTH)
		if health == 0:
			emit_signal("starved")
		else:
			emit_signal("health_changed", health)


func _ready():
	health = MAX_HEALTH


func _process(delta):
	if Input.is_action_pressed("ui_right"):
		position.x += speed * delta
	if Input.is_action_pressed("ui_up"):
		position.y -= speed / 2 * delta
	if Input.is_action_pressed("ui_down"):
		position.y += speed / 2 * delta
	position.x -= speed * delta * float_factor_x


func _on_hunger_timer_timeout():
	health -= 1


func _on_player_eat_fish():
	health += 5
