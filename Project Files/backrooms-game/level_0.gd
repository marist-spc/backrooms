extends Node3D

var combat_scene = preload("res://PartygoerFight.tscn").instantiate()

func _on_party_goer_start_combat() -> void:
	get_tree().root.add_child(combat_scene)
