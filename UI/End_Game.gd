extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_restart_1_pressed():
	get_tree().paused = false
	Global.reset()
	var _scene = get_tree().change_scene_to_file("res://Game.tscn")

func _on_quit_1_pressed():
	get_tree().quit()
