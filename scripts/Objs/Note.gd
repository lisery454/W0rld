extends MovableObj
class_name Note


func _ready():
	information = "A paper that says \"I'm going to the REVERSE world because everything is nothing.\"";

func on_throw(_speed: Vector2):
	if $ShapeCast2D.is_colliding() :
		var area = $ShapeCast2D.get_collider(0) as Node2D
		var the_world = area.get_parent() as TheWorld
		if the_world != null:
			if the_world.is_flip && the_world.is_reverse:
				the_world.disapper()
				queue_free()
