extends StaticBody3D

func interact():
	Global.inventory_star_candy += 1
	queue_free()
