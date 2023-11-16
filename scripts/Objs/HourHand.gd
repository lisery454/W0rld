extends MovableObj
class_name HourHand


func _ready():
	information = "A hour hand. The hands of time will PRY something open."
	
	
func on_throw(_speed: Vector2):
	if $"RayCast2D".is_colliding() :
		var area = $"RayCast2D".get_collider() as Node2D
		var jar = area.get_parent() as Jar
		if jar != null:
			jar.get_pill()
			queue_free()


