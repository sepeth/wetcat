extends Node2D

const JumpingFishScene = preload("res://Scenes/JumpingCarp.tscn")

@onready var fish_timer = Timer.new()
@onready var time_alive_timer = Timer.new()
@onready var rng = RandomNumberGenerator.new()

var time_alive = 0


func _ready():
	add_child(fish_timer)
	fish_timer.connect("timeout", add_fish)
	fish_timer.set_wait_time(3.0)
	fish_timer.start()


	add_child(time_alive_timer)
	time_alive_timer.connect("timeout", increase_time_alive)
	time_alive_timer.set_wait_time(1.0)
	start_game()


func start_game():
	time_alive = 0
	time_alive_timer.start()


func increase_time_alive():
	time_alive += 1
	$HUD/TimeAliveLabel.text = "%d" % time_alive


func add_fish():
	var padding = 200
	var box_size = get_viewport_rect().size
	var new_wait = rng.randi_range(0, 3)
	fish_timer.set_wait_time(new_wait)
	var fish = JumpingFishScene.instantiate()
	fish.got_caught.connect($Player._on_player_eat_fish)
	fish.position.x = rng.randi_range(padding, box_size.x - padding)
	fish.position.y = rng.randi_range(padding, box_size.y - padding)
	add_child(fish)


func _on_player_starved():
	# Game over
	$GameOverScene.visible = true
	$Player.visible = false
	$HUD.visible = false


func _on_game_over_scene_quit_pressed():
	get_tree().quit()


func _on_game_over_scene_restart_pressed():
	$Player.reset()
	$HUD.visible = true
	$Player.visible = true
	$GameOverScene.visible = false


func _physics_process(delta):
	pass
