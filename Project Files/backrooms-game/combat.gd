extends Node2D

var turn = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if turn == 1 and $enemy.health > 0:
		turn = 0
		await get_tree().create_timer(3).timeout
		$Player.health -= randi_range(10,15) * $enemy.attack / $Player.defense
		var health_text = str($Player.health)
		$Player/Label.text = health_text
		$Button.disabled = false

func _on_button_pressed() -> void:
	$enemy.health -= $Player.attack * 10 / 3 - $enemy.defense
	var health_text = str($enemy.health)
	$enemy/Label.text = health_text
	turn += 1
	$Button.disabled = true
