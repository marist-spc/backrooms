extends Node3D

signal Start_Boss_Fight

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite3D.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	emit_signal("Start_Boss_Fight")


func _on_player_3d_delete_boss() -> void:
	queue_free()
