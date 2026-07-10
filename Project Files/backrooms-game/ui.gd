extends Control

func _process(_delta: float) -> void:
	$HealthBar.value = Global.player_health
	$Label.text = "Level: " + str(Global.player_level)
	$LevelBar.max_value = Global.player_level_up_exp
	$LevelBar.value = Global.player_exp




func _on_player_max_health_var(max_health) -> void:
	$HealthBar.max_value = max_health


func _on_player_health_var(health) -> void:
	$HealthBar.value = health
