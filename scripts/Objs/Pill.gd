extends MovableObj
class_name Pill


func _ready():
	information = "A pill. Can medicine really save a JOKER's heart?"


func on_throw(_speed: Vector2):
	if $RayCast2D.is_colliding() :
		var area = $RayCast2D.get_collider() as Node2D
		var joker = area.get_parent() as Joker
		if joker != null:
			if joker.is_soothe:
				joker.add_pill()
				queue_free()
