extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.player_health < 100:
		Global.player_health = 100
	Global.in_combat = false
	Global.player_max_health = 100
	Global.player_exp = 0
	Global.player_level = 1
	Global.player_attack = 5
	Global.player_defense = 3
	Global.player_level_up_exp = 5
	Global.player_healing_time = 5
	Global.standard_defense = 3
	Global.player_max_sp = 5
	Global.player_healing = 1
	Global.inventory_almond_water = 0
	Global.inventory_star_candy = 0
	Global.player_sp_increase


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://level_0.tscn")


func _on_menu_button_pressed() -> void:
	pass # Replace with function body.


func _on_exit_button_pressed() -> void:
	get_tree().quit()
