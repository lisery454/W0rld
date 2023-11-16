extends MovableObj
class_name Jar


@export var boom_size : float = 1.5
@export var boom_prefab: PackedScene
@export var pill_prefab: PackedScene

func _ready():
	information = "A medicine jar. I take medicine regularly now. But why can't this be opened?"


func get_pill():
	var pill = pill_prefab.instantiate() as Pill
	get_parent().add_child(pill)
	pill.global_position = $"Marker2D".global_position
	var boom = boom_prefab.instantiate() as Boom
	get_parent().add_child(boom)
	boom.global_position = $"Marker2D".global_position
	boom.play(Vector2.ONE * boom_size)
	queue_free()


