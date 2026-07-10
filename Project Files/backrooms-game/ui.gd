extends Control

func _process(_delta: float) -> void:
	$HealthBar.value = Global.player_health




func _on_player_max_health_var(max_health) -> void:
	$HealthBar.max_value = max_health


func _on_player_health_var(health) -> void:
	$HealthBar.value = health
