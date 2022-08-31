extends ParallaxBackground

@export
var direction = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if direction == 0:
		scroll_base_offset -= Vector2(100,0) * delta
	else:
		scroll_base_offset += Vector2(100,0) * delta
