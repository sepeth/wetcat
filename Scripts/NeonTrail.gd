extends Line2D

@export
var grad : Gradient
@export
var speed := 1.0
@export
var precision := 1.0

var follows := []

@onready
var path := $CurrentPath

func _ready():
	for i in 5*precision:
		var new_follow = PathFollow2D.new()
		new_follow.set_loop(false)
		path.add_child(new_follow)
		new_follow.unit_offset = float(i*0.02/precision)
		follows.append(new_follow)


func _process(delta):
	clear_points()
	for f in follows:
		f.unit_offset = wrapf(f.unit_offset + delta * speed, 0, 1)
		add_point(f.global_position)
	
	gradient.colors[0] = grad.interpolate(follows[0].unit_offset)
	gradient.colors[1] = grad.interpolate(follows[-1].unit_offset)
