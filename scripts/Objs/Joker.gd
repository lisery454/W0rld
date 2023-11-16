extends MovableObj
class_name Joker

@export var boom_size : float = 1.2
@export var boom_prefab: PackedScene
@export var note_prefab: PackedScene

var is_soothe: bool

func _ready():
	information = "A joker, but it's damaged and BROKEN."

func soothe():
	if !is_soothe:
		$Sprite2D.texture = load("res://images/joker.png")
		is_soothe = true
		information = "A joker, he seemed sad."
		var boom = boom_prefab.instantiate() as Boom
		get_parent().add_child(boom)
		boom.global_position = $"Marker2D".global_position
		boom.play(Vector2.ONE * boom_size)


func add_pill():
	var note = note_prefab.instantiate() as Note
	get_parent().add_child(note)
	note.global_position = $"Marker2D".global_position
	var boom = boom_prefab.instantiate() as Boom
	get_parent().add_child(boom)
	boom.global_position = $"Marker2D".global_position
	boom.play(Vector2.ONE * boom_size)
	queue_free()
