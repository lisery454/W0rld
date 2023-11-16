extends MovableObj
class_name  Milk


func _ready():
	information = "Milk. I don't drink wine. I drink milk to soothe my BROKEN heart.";

func on_throw(_speed: Vector2):
	if $ShapeCast2D.is_colliding() :
		var area = $ShapeCast2D.get_collider(0) as Node2D
		var joker = area.get_parent() as Joker
		if joker != null:
			joker.soothe()
			queue_free()
