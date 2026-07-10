extends Node3D

func _process(_delta: float) -> void:
	if Global.player_health <= 0:
		get_tree().change_scene_to_file("res://main_menu.tscn")
