extends CharacterBody2D

signal starved
signal health_changed(health)

@export var speed = 300
@export var float_factor_x = 0.5
@export var top_current_y = 250
@export var bot_current_y = 530
@export var current_speed = 350

const MAX_HEALTH = 30

var health :
	set(value):
		health = clamp(value, 0, MAX_HEALTH)
		if health == 0:
			emit_signal("starved")
		else:
			emit_signal("health_changed", health)


func _ready():
	reset()


func reset():
	health = MAX_HEALTH
	# Move player to center of screen
	position = get_viewport_rect().size / 2


func _process(delta):
	if position.y < top_current_y:
		position.x += current_speed * delta
	if position.y > bot_current_y:
		position.x -= current_speed * delta
	if Input.is_action_pressed("ui_right"):
		position.x += speed * delta
	if Input.is_action_pressed("ui_up"):
		position.y -= speed / 2 * delta
	if Input.is_action_pressed("ui_down"):
		position.y += speed / 2 * delta
	position.x -= speed * delta * float_factor_x

	# Basic collisions for side of screen
	var screen_size = get_viewport_rect().size
	position.x = clamp(position.x, 0, screen_size.x)
	# HACK: hardcoded paddings
	position.y = clamp(position.y, 200, screen_size.y - 450)


func _on_hunger_timer_timeout():
	health -= 1


func _on_player_eat_fish():
	health += 5
