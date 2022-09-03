extends Node2D

const JumpingFishScene = preload("res://Scenes/JumpingCarp.tscn")

@onready var fish_timer = Timer.new()
@onready var time_alive_timer = Timer.new()
@onready var rng = RandomNumberGenerator.new()

var game_over = false
var time_alive = 0
var eaten_fish_count = 0
var missed_fish_count = 0


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
	if game_over:
		return
	time_alive += 1
	$HUD/TimeAliveLabel.text = "%d" % time_alive


func add_fish():
	var padding = 200
	var box_size = get_viewport_rect().size
	var new_wait = rng.randi_range(0, 3)
	fish_timer.set_wait_time(new_wait)
	var fish = JumpingFishScene.instantiate()
	fish.got_caught.connect(eat_fish)
	fish.got_away.connect(miss_fish)
	fish.position.x = rng.randi_range(padding, box_size.x - padding)
	fish.position.y = rng.randi_range(padding, box_size.y - padding)
	add_child(fish)


func eat_fish():
	eaten_fish_count += 1
	$Player._on_player_eat_fish()
	$HUD/EatenFishLabel.text = "%d" % eaten_fish_count


func miss_fish():
	if game_over:
		return
	missed_fish_count += 1
	$HUD/UneatenFishLabel.text = "%d" % missed_fish_count


func _on_player_starved():
	# Game over
	$GameOverScene.visible = true
	$HUD/Health.visible = false
	$Player.visible = false
	game_over = true


func _on_game_over_scene_restart_pressed():
	$GameOverScene.visible = false
	$HUD/Health.visible = true
	$Player.visible = true
	$Player.reset()
	game_over = false
	time_alive = 0
	eaten_fish_count = 0
	missed_fish_count = 0


func _on_game_over_scene_quit_pressed():
	get_tree().quit()


func _physics_process(delta):
	pass
