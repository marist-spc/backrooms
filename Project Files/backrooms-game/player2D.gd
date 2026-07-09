extends Node2D

var weapon = {}
var armor = {}
var Inventory = {"almond water": 5, "star candy": 2, "another fucking item idk": 0}
@export var health = 100
@export var max_health = 100
@export var SP = 20
@export var max_SP = 20
@export var attack = 5
@export var defense = 3
@export var standard_defense = 3
@export var exp:int = 0
@export var level:int = 1
@export var level_up_exp:int = 50

func level_up():
	if exp >= level_up_exp:
		exp -= level_up_exp
		level += 1
		attack += 1
		defense += 1
		max_health += 10
		max_SP += 5
		level_up_exp *= 1.35

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
