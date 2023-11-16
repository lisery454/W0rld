extends MovableObj
class_name PiggyBank

var count: int = 0

@export var boom_size : float = 2
@export var boom_prefab: PackedScene
@export var milk_prefab: PackedScene
@export var jar_prefab: PackedScene

func _ready():
	information = "A piggy bank. When I was a kid, I always wanted to fill it up"


func add_coin():
	count += 1
	if count >= 3:
		var milk = milk_prefab.instantiate() as Milk
		get_parent().call_deferred("add_child", milk)
		milk.global_position = $"MarkerMilk".global_position
		var jar = jar_prefab.instantiate() as Jar
		get_parent().call_deferred("add_child", jar)
		jar.global_position = $"MarkerJar".global_position
		var boom = boom_prefab.instantiate() as Boom
		get_parent().add_child(boom)
		boom.global_position = $"Marker2D".global_position
		boom.play(Vector2.ONE * boom_size)
		queue_free()
