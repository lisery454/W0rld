extends MovableObj
class_name RubikCube

@export var need_count: int = 3
var curr_count: int = 0

@onready var marker2D: Marker2D = $"Marker2D"
@export var boom_size : float = 1.2
@export var boom_prefab: PackedScene
@export var dice_prefab: PackedScene


func _ready():
	information = "A rubik's cube. I played this well before, but now I'll just BREAK it"
	body_entered.connect(
		func (_body: Node) :
			if curr_count < need_count:
				($"/root/AudioManagerInstance" as AudioManager).play("rubik_play")
				curr_count += 1
			else :
				var boom = boom_prefab.instantiate() as Boom
				get_parent().add_child(boom)
				boom.global_position = marker2D.global_position
				boom.play(Vector2.ONE * boom_size)
				var dice = dice_prefab.instantiate() as Dice
				get_parent().call_deferred("add_child", dice)
				dice.global_position = marker2D.global_position
				call_deferred("queue_free")				
	)


