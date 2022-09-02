extends Node2D

signal restart_pressed
signal quit_pressed


func _on_restart_button_pressed():
	emit_signal("restart_pressed")


func _on_quit_button_pressed():
	emit_signal("quit_pressed")
