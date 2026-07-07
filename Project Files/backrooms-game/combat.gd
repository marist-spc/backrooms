extends Node2D

var turn = 0
@onready var player_health = str($Player.health)
@onready var max_player_health = str($Player.max_health)
@onready var enemy_health = str($enemy.health)
@onready var max_enemy_health = str($enemy.max_health)
@onready var player_SP = str($Player.SP)
@onready var max_player_SP = str($Player.max_SP)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player/Label.text = "HP: " + player_health + "/" + max_player_health
	$enemy/Label.text = "HP: " + enemy_health + "/" + max_enemy_health
	$Player/SP.text = "SP: " + player_SP + "/" + max_player_SP

func set_player_health():
	player_health = str($Player.health)
func update_player_health():
	$Player/Label.text = "HP: " + player_health + "/" + max_player_health
func set_enemy_health():
	enemy_health = str($enemy.health)
func update_enemy_health():
	$enemy/Label.text = "HP: " + enemy_health + "/" + max_enemy_health
func set_player_SP():
	player_SP = str($Player.SP)
func update_SP():
	$Player/SP.text = "SP: " + player_SP + "/" + max_player_SP

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if turn == 1 and $enemy.health > 0:
		turn = 0
		await get_tree().create_timer(1).timeout
		$Player.health -= randi_range(10,15) * $enemy.attack / $Player.defense
		set_player_health()
		update_player_health()
		$Attack.disabled = false
		$Block.disabled = false
		$Item.disabled = false
		$Ability.disabled = false
		$Bash.visible = false
		$SuperBash.visible = false
		$Bash.disabled = true
		$SuperBash.disabled = true
		$Ability.visible = true

func _on_button_pressed() -> void:
	$enemy.health -= $Player.attack * 10 / 3 - $enemy.defense
	set_enemy_health()
	update_enemy_health()
	turn += 1
	$Attack.disabled = true
	$Block.disabled = true
	$Item.disabled = true
	$Ability.disabled = true
	$Bash.visible = false
	$SuperBash.visible = false
	$Bash.disabled = true
	$SuperBash.disabled = true
	$Ability.visible = true

func _on_block_pressed() -> void:
	$Attack.disabled = true
	$Block.disabled = true
	$Item.disabled = true
	$Ability.disabled = true
	$Ability.visible = true
	$Bash.visible = false
	$SuperBash.visible = false
	$Bash.disabled = true
	$SuperBash.disabled = true
	$"Almond Water".visible = false
	$"Almond Water".disabled = true
	await get_tree().create_timer(1).timeout
	$Player.health -= randi_range(10,15) * $enemy.attack / ($Player.defense * 3)
	set_player_health()
	update_player_health()
	$Attack.disabled = false
	$Block.disabled = false
	$Item.disabled = false
	$Ability.disabled = false

	


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
	set_player_health()
	update_player_health()
	$"Almond Water".disabled = true
	$"Almond Water".visible = false
	$Item.visible = true
	$Attack.disabled = true
	$Block.disabled = true
	$Ability.disabled = true
	$Bash.visible = false
	$SuperBash.visible = false
	$Bash.disabled = true
	$SuperBash.disabled = true
	$Ability.visible = true
	turn += 1





func _on_ability_pressed() -> void:
	$Bash.visible = true
	$SuperBash.visible = true
	$Bash.disabled = false
	$SuperBash.disabled = false
	$Ability.visible = false
	$Ability.disabled = true


func _on_bash_pressed() -> void:
	$enemy.health -= $Player.attack * 10 / 2
	set_enemy_health()
	update_enemy_health()
	$Player.SP -= 2
	set_player_SP()
	update_SP()
	$Bash.visible = false
	$SuperBash.visible = false
	$Bash.disabled = true
	$SuperBash.disabled = true
	$Ability.visible = true
	$Attack.disabled = true
	$Block.disabled = true
	$Item.disabled = true
	turn += 1

func _on_super_bash_pressed() -> void:
	$enemy.health -= $Player.attack * 5 / 2
	set_enemy_health()
	update_enemy_health()
	await get_tree().create_timer(0.5).timeout
	$enemy.health -= $Player.attack * 5 / 2
	set_enemy_health()
	update_enemy_health()
	await get_tree().create_timer(0.5).timeout
	$enemy.health -= $Player.attack * 5 / 2
	set_enemy_health()
	update_enemy_health()
	$Player.SP -= 4
	set_player_SP()
	update_SP()
	$Bash.visible = false
	$SuperBash.visible = false
	$Bash.disabled = true
	$SuperBash.disabled = true
	$Ability.visible = true
	$Attack.disabled = true
	$Block.disabled = true
	$Item.disabled = true
	turn += 1
