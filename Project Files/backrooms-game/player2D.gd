extends Node2D

var weapon = {}
var armor = {}
var Inventory = {"almond water": 5, "item": 0, "another fucking item idk": 0}
@export var health = 100
@export var max_health = 100
@export var SP = 10
@export var max_SP = 10
@export var attack = 5
@export var defense = 3
@export var standard_defense = 3
@export var exp:int
@export var level:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
