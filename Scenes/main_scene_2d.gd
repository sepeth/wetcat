extends Node2D

const JumpingFishScene = preload("res://Scenes/JumpingCarp.tscn")

@onready var fish_timer = Timer.new()
@onready var time_alive_timer = Timer.new()
@onready var difficulty_timer = Timer.new()
@onready var rng = RandomNumberGenerator.new()

var game_started = false
var game_over = false

var time_alive = 0 :
	set(value):
		time_alive = value
		$HUD/TimeAliveLabel.text = "%d" % time_alive

var eaten_fish_count = 0 :
	set(value):
		eaten_fish_count = value
		$HUD/EatenFishLabel.text = "%d" % eaten_fish_count

var missed_fish_count = 0 :
	set(value):
		missed_fish_count = value
		$HUD/UneatenFishLabel.text = "%d" % missed_fish_count


func _ready():
	add_child(fish_timer)
	fish_timer.connect("timeout", add_fish)
	fish_timer.set_wait_time(3.0)
	fish_timer.start()

	add_child(time_alive_timer)
	time_alive_timer.connect("timeout", increase_time_alive)
	time_alive_timer.set_wait_time(1.0)

	add_child(difficulty_timer)
	difficulty_timer.set_wait_time(30.0)
	difficulty_timer.connect("timeout", reduce_max_health)



func start_game():
	game_started = true
	game_over = false
	eaten_fish_count = 0
	missed_fish_count = 0
	time_alive = 0
	time_alive_timer.start()
	difficulty_timer.start()
	$Player.reset()
	$Player/HungerTimer.start()
	$Player.visible = true
	$HUD.visible = true
	$StartScene.visible = false
	$GameOverScene.visible = false
	$HUD/Health.visible = true
	$Player.visible = true
	$Environment/BackgroundParent/ParallaxArrow.visible = true
	$Environment/BackgroundParent/ArrowLeft.visible = true


func _on_player_starved():
	game_over = true
	$GameOverScene.visible = true
	$HUD/Health.visible = false
	$Player.visible = false
	$Player/HungerTimer.stop()
	$Environment/BackgroundParent/ParallaxArrow.visible = false
	$Environment/BackgroundParent/ArrowLeft.visible = false


func increase_time_alive():
	if game_over:
		return
	time_alive += 1


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
	if game_over or not game_started:
		return
	eaten_fish_count += 1
	$Player._on_player_eat_fish()


func miss_fish():
	if game_over:
		return
	missed_fish_count += 1


func reduce_max_health():
	$Player.current_max_health -= 1


func _on_game_over_scene_restart_pressed():
	start_game()


func _on_game_over_scene_quit_pressed():
	get_tree().quit()


func _physics_process(delta):
	pass
