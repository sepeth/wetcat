extends Node2D


signal got_away
signal got_caught


@export var jump_speed = 500
@onready var path = %PathFollow2D


func _physics_process(delta):
	# TODO: This should be tween, it looks pretty static.
	path.progress += jump_speed * delta
	if path.progress_ratio > 0.99:
		emit_signal("got_away")
		queue_free()


func _on_area_2d_body_entered(body):
	emit_signal("got_caught")
	queue_free()
