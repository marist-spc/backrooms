extends Control


func _on_player_health_var(health) -> void:
	$HealthBar.value = health


func _on_player_max_health_var(max_health) -> void:
	$HealthBar.max_value = max_health
