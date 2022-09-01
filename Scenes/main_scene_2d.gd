extends Node2D

const JumpingFishScene = preload("res://Scenes/JumpingCarp.tscn")

@onready var fish_timer = Timer.new()
@onready var rng = RandomNumberGenerator.new()


func _ready():
	# Move player to center of screen
	$Player.position = get_viewport_rect().size / 2

	add_child(fish_timer)
	fish_timer.connect("timeout", _on_Timer_timeout)
	fish_timer.set_wait_time(3.0)
	fish_timer.set_one_shot(false)
	fish_timer.start()


func _on_Timer_timeout():
	add_fish()


func add_fish():
	var padding = 200
	var box_size = get_viewport_rect().size
	var new_wait = rng.randi_range(3, 6)
	fish_timer.set_wait_time(new_wait)
	var fish = JumpingFishScene.instantiate()
	fish.got_caught.connect($Player._on_player_eat_fish)
	fish.position.x = rng.randi_range(padding, box_size.x - padding)
	fish.position.y = rng.randi_range(padding, box_size.y - padding)
	add_child(fish)
