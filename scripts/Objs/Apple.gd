extends MovableObj
class_name Apple

@onready var marker2D: Marker2D = $"Marker2D"
@export var boom_size : float = 1.2
@export var boom_prefab: PackedScene
@export var coin_prefab: PackedScene

func _ready():
	information = "An apple. My mother loved eating apples when she was alive."

func on_throw(_speed: Vector2):
	if $ShapeCast2D.is_colliding() :
		var area = $ShapeCast2D.get_collider(0) as Node2D
		var the_high_priestess = area.get_parent() as TheHighPriestess
		if the_high_priestess != null:
			if the_high_priestess.is_flip:
				the_high_priestess.queue_free()
				var boom = boom_prefab.instantiate() as Boom
				get_parent().add_child(boom)
				boom.global_position = marker2D.global_position
				boom.play(Vector2.ONE * boom_size)
				var coin = coin_prefab.instantiate() as Coin
				get_parent().add_child(coin)
				coin.global_position = marker2D.global_position
				coin.information = "A `coin`. Maybe an apple core."
				queue_free()
			
