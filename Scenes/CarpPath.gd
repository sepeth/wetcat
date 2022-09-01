extends PathFollow2D

@export var jump_speed = 500


func _physics_process(delta):
	# TODO: This should be tween, it looks pretty static.
	progress += jump_speed * delta
	if progress_ratio > 0.99:
		queue_free()
