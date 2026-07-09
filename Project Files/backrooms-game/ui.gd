extends Control

var health = 50
var max_health = 100

func _ready() -> void:
	$HealthBar.max_value = max_health
	$HealthBar.value = health
