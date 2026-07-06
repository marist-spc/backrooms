extends Node2D

var turn = 0
var player_health = str($Player.health)
var enemy_health = str($enemy.health)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player/Label.text = player_health
	$enemy/Label.text = enemy_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if turn == 1 and $enemy.health > 0:
		turn = 0
		await get_tree().create_timer(3).timeout
		$Player.health -= randi_range(10,15) * $enemy.attack / $Player.defense
		$Player/Label.text = player_health
		$Button.disabled = false

func _on_button_pressed() -> void:
	$enemy.health -= $Player.attack * 10 / 3 - $enemy.defense
	$enemy/Label.text = enemy_health
	turn += 1
	$Button.disabled = true
