extends PathFollow2D

@export var jump_speed = 500


func _ready():
	$FishSprite.visible = true


func _physics_process(delta):
	if abs(1 - progress_ratio) < 0.01:
		# Done jumping
		$FishSprite.visible = false
	else:
		# TODO: This should be tween, it looks pretty static.
		progress += jump_speed * delta
