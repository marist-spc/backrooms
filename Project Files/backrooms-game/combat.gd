extends Node2D

var turn = 0
@onready var player_health = str($Player.health)
@onready var enemy_health = str($enemy.health)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player/Label.text = player_health
	$enemy/Label.text = enemy_health



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if turn == 1 and $enemy.health > 0:
		turn = 0
		await get_tree().create_timer(3).timeout
		$Player.health -= randi_range(10,15) * $enemy.attack / $Player.defense
		player_health = str($Player.health)
		$Player/Label.text = player_health
		$Attack.disabled = false
		$Block.disabled = false
		$Item.disabled = false

func _on_button_pressed() -> void:
	$enemy.health -= $Player.attack * 10 / 3 - $enemy.defense
	enemy_health = str($enemy.health)
	$enemy/Label.text = enemy_health
	turn += 1
	$Attack.disabled = true
	$Block.disabled = true
	$Item.disabled = true

func _on_block_pressed() -> void:
	$Attack.disabled = true
	$Block.disabled = true
	$Item.disabled = true
	await get_tree().create_timer(3).timeout
	$Player.health -= randi_range(10,15) * $enemy.attack / ($Player.defense * 3)
	player_health = str($Player.health)
	$Player/Label.text = player_health
	$Attack.disabled = false
	$Block.disabled = false
	$Item.disabled = false


func _on_item_pressed() -> void:
	$Item.visible = false
	$Item.disabled = true
	if $Player.Inventory["almond water"] > 0:
		$"Almond Water".visible = true
		$"Almond Water".disabled = false
		
	else:
		$None.visible = true

func _on_almond_water_pressed() -> void:
	$Player.health += 20
	if $Player.health > $Player.max_health:
		$Player.health = $Player.max_health
	player_health = str($Player.health)
	$Player/Label.text = player_health
	$"Almond Water".disabled = true
	$"Almond Water".visible = false
	$Item.visible = true
	$Attack.disabled = true
	$Block.disabled = true
	turn += 1
