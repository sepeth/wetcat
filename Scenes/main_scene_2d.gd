extends Node2D


func _ready():
    # Move player to center of screen
    $Player.position = get_viewport_rect().size / 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass
