extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.player_health < 100:
		Global.player_health = 100
	Global.in_combat = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://level_0.tscn")


func _on_menu_button_pressed() -> void:
	pass # Replace with function body.


func _on_exit_button_pressed() -> void:
	get_tree().quit()
