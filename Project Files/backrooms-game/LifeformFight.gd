extends Node2D

var turn = 0
@onready var player_health = str($Player.health)
@onready var max_player_health = str($Player.max_health)
@onready var enemy_health = str($Lifeform.health)
@onready var max_enemy_health = str($Lifeform.max_health)
@onready var player_SP = str($Player.SP)
@onready var max_player_SP = str($Player.max_SP)
var player_health_changed

signal change_player_health


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player/Label.text = "HP: " + player_health + "/" + max_player_health
	$Lifeform/Label.text = "HP: " + enemy_health + "/" + max_enemy_health
	$Player/SP.text = "SP: " + player_SP + "/" + max_player_SP
	$Lifeform/action.text = "Lifeform slinks in!"

func set_player_health():
	player_health = str($Player.health)
func update_player_health():
	$Player/Label.text = "HP: " + player_health + "/" + max_player_health
func set_enemy_health():
	enemy_health = str($Lifeform.health)
func update_enemy_health():
	$Lifeform/Label.text = "HP: " + enemy_health + "/" + max_enemy_health
func set_player_SP():
	player_SP = str($Player.SP)
func update_SP():
	$Player/SP.text = "SP: " + player_SP + "/" + max_player_SP

var enemy_turn = [attack, defend, Defense_lower]

func attack():
	$Player.health -= randi_range(10,15) * $Lifeform.attack / $Player.defense
	set_player_health()
	update_player_health()
	$Lifeform/action.text = "Lifeform attacks!"

func defend():
	$Lifeform.defense += 3
	$Lifeform/action.text = "Lifeform defends."

func Defense_lower():
	if $Player.defense < 0:
		$Player.defense = 1
	$Player.health -= randi_range(10,16) * ($Lifeform.attack / $Player.defense) - 2
	set_player_health()
	update_player_health()
	$Player.defense /= 2
	$Lifeform/action.text = "Lifeform attacks! Your defense has been lowered!"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$PlayerHealthBar.value = $Player.health
	$PlayerHealthBar.max_value = $Player.max_health
	$LifeformHealthBar.value = $Lifeform.health
	$LifeformHealthBar.max_value = $Lifeform.max_health
	
	player_health_changed = $Player.health
	
	if $Player.SP < 0 :
		$Player.SP = 0
	if $Player.health <= 0 :
		Global.player_health = 0
		update_player_health()
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://main_menu.tscn")
		get_node(".").queue_free()
	if turn == 1 and $Lifeform.health > 0:
		turn = 0
		await get_tree().create_timer(1).timeout
		var turn_action = enemy_turn[randi_range(0, 2)]
		turn_action.call()
		$Attack.disabled = false
		$Block.disabled = false
		$Item.disabled = false
		$Ability.disabled = false
		$Bash.visible = false
		$SuperBash.visible = false
		$Bash.disabled = true
		$SuperBash.disabled = true
		$Ability.visible = true
		if turn_action != Defense_lower:
			$Player.defense = $Player.standard_defense
	
	$"Almond Water/Label".text = str(Global.inventory_almond_water)
	$StarCandy/Label.text = str(Global.inventory_star_candy)
	
	
	if $Lifeform.health == 0:
		Global.player_exp += 1
		change_player_health.emit(player_health_changed)
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		Global.in_combat = false
		get_node(".").queue_free()

func _on_button_pressed() -> void:
	$Lifeform.health -= $Player.attack * 10 / 3 - $Lifeform.defense
	if $Lifeform.health < 0:
		$Lifeform.health = 0
	set_enemy_health()
	update_enemy_health()
	$Lifeform.defense = $Lifeform.standard_defense
	turn += 1
	$Attack.disabled = true
	$Block.disabled = true
	$Item.disabled = true
	$Item.visible = true
	$"Almond Water".visible = false
	$"Almond Water".disabled = true
	$StarCandy.visible = false
	$StarCandy.disabled = true
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
	$Item.visible = true
	$Bash.visible = false
	$SuperBash.visible = false
	$Bash.disabled = true
	$SuperBash.disabled = true
	$"Almond Water".visible = false
	$"Almond Water".disabled = true
	$StarCandy.visible = false
	$StarCandy.disabled = true
	$Player.defense *= 3
	turn += 1

	


func _on_item_pressed() -> void:
	$Item.visible = false
	$Item.disabled = true
	if Global.inventory_almond_water > 0:
		$"Almond Water".visible = true
		$"Almond Water".disabled = false
	if Global.inventory_star_candy > 0:
		$StarCandy.visible = true
		$StarCandy.disabled = false
	else:
		$Item.visible = true
		$Item.disabled = false

func _on_almond_water_pressed() -> void:
	$Lifeform.defense = $Lifeform.standard_defense
	$Player.health += 20
	Global.inventory_almond_water -= 1
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
	$StarCandy.visible = false
	$StarCandy.disabled = true
	turn += 1





func _on_ability_pressed() -> void:
	$Bash.visible = true
	$SuperBash.visible = true
	if $Player.SP > 1 :
		$Bash.disabled = false
	if $Player.SP > 3:
		$SuperBash.disabled = false
	$Ability.visible = false
	$Ability.disabled = true


func _on_bash_pressed() -> void:
	$Lifeform.health -= $Player.attack * 10 / 2
	if $Lifeform.health < 0:
		$Lifeform.health = 0
	set_enemy_health()
	update_enemy_health()
	$Lifeform.defense = $Lifeform.standard_defense
	$Player.SP -= 2
	set_player_SP()
	update_SP()
	$"Almond Water".disabled = true
	$"Almond Water".visible = false
	$Item.visible = true
	$Bash.visible = false
	$SuperBash.visible = false
	$Bash.disabled = true
	$SuperBash.disabled = true
	$Ability.visible = true
	$Attack.disabled = true
	$Block.disabled = true
	$Item.disabled = true
	$StarCandy.visible = false
	$StarCandy.disabled = true
	turn += 1

func _on_super_bash_pressed() -> void:
	$Lifeform.health -= $Player.attack * 5 / 2
	if $Lifeform.health < 0:
		$Lifeform.health = 0
	set_enemy_health()
	update_enemy_health()
	await get_tree().create_timer(0.15).timeout
	$Lifeform.health -= $Player.attack * 5 / 2
	if $Lifeform.health < 0:
		$Lifeform.health = 0
	set_enemy_health()
	update_enemy_health()
	await get_tree().create_timer(0.25).timeout
	$Lifeform.health -= $Player.attack * 5 / 2
	if $Lifeform.health < 0:
		$Lifeform.health = 0
	set_enemy_health()
	update_enemy_health()
	$Lifeform.defense = $Lifeform.standard_defense
	$Player.SP -= 4
	set_player_SP()
	update_SP()
	$"Almond Water".disabled = true
	$"Almond Water".visible = false
	$StarCandy.visible = false
	$StarCandy.disabled = true
	$Item.visible = true
	$Bash.visible = false
	$SuperBash.visible = false
	$Bash.disabled = true
	$SuperBash.disabled = true
	$Ability.visible = true
	$Attack.disabled = true
	$Block.disabled = true
	$Item.disabled = true
	turn += 1


func _on_star_candy_pressed() -> void:
	$Lifeform.defense = $Lifeform.standard_defense
	$Player.SP += 5
	Global.inventory_star_candy -= 1
	if $Player.SP > $Player.max_SP:
		$Player.SP = $Player.max_SP
	set_player_SP()
	update_SP()
	$"Almond Water".disabled = true
	$"Almond Water".visible = false
	$StarCandy.visible = false
	$StarCandy.disabled = true
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
