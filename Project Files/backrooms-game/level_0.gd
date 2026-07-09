extends Node3D

var combat_scene

func _on_party_goer_start_combat() -> void:
	combat_scene = preload("res://PartygoerFight.tscn").instantiate()
	get_tree().root.add_child(combat_scene)
