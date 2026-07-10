extends StaticBody3D

func interact():
	Global.inventory_almond_water += 1
	queue_free()
