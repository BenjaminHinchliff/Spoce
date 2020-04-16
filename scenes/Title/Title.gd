extends Control

var _main: PackedScene = preload("res://scenes/Main/Main.tscn")

func _on_Start_pressed() -> void:
	if(get_tree().change_scene_to(_main) == ERR_CANT_CREATE):
		printerr("Cannot instantiate main scene, critical error... exiting")
		get_tree().quit(1)
