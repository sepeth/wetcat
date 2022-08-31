extends CharacterBody2D

@export var speed = 100
@export var float_factor_x = 0.5


func _process(delta):
	if Input.is_action_pressed("ui_right"):
		position.x += speed * delta
	else:
		position.x -= speed * delta * float_factor_x
