extends Node2D

var weapon = {}
var armor = {}
var Inventory = {"almond water": 5, "star candy": 2, "another fucking item idk": 0}
@export var health: int = Global.player_health
@export var max_health: int = Global.player_max_health
@export var SP = Global.player_sp
@export var max_SP = Global.player_max_sp
@export var attack = Global.player_attack
@export var defense = Global.player_defense
@export var standard_defense = Global.standard_defense
@export var expoint = Global.player_exp
@export var level= Global.player_level
@export var level_up_exp = Global.player_level_up_exp

signal health_var
signal max_health_var

func level_up():
	if expoint >= level_up_exp:
		expoint -= level_up_exp
		level += 1
		attack += 1
		defense += 1
		max_health += 10
		max_SP += 5
		level_up_exp *= 1.35

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("idle")
	health_var.emit(health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	max_health_var.emit(max_health)

func health_change(player_health_changed):
	Global.player_health = player_health_changed
