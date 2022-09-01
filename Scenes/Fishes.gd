extends Node

const JumpingFishScene = preload("res://Scenes/JumpingCarp.tscn")
const padding = 200

@onready var timer = Timer.new()
@onready var rng = RandomNumberGenerator.new()

# HACK: parent should set this
@onready var box_size = get_parent().get_viewport_rect().size


func _ready():
	add_child(timer)
	timer.connect("timeout", _on_Timer_timeout)
	timer.set_wait_time(3.0)
	timer.set_one_shot(false)
	timer.start()


func _on_Timer_timeout():
	var new_wait = rng.randi_range(3, 6)
	timer.set_wait_time(new_wait)
	var fish = JumpingFishScene.instantiate()
	fish.position.x = rng.randi_range(padding, box_size.x - padding)
	fish.position.y = rng.randi_range(padding, box_size.y - padding)
	add_child(fish)

