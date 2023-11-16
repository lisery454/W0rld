extends MovableObj
class_name TheWorld

@onready var animation_player : AnimationPlayer = $AnimationPlayer
var is_flip : bool 
var is_reverse: bool

@export var boom_size : float = 1.5
@export var boom_prefab: PackedScene
@export var end_label: Label
@export var input_manager: InputManager


func _ready():
	information = "A tarot card. Try to turn it over"
	is_flip = false
	is_reverse = false

func on_throw(speed: Vector2):
	if(!is_flip && abs(speed.x) > 900):
		animation_player.play("flip")
		is_flip = true
		information = "THE WORLD. A beautiful world full of hope."

func reverse():
	is_reverse = true;
	$Sprite2D.texture = load("res://images/the_world_reverse.png")
	information = "THE WORLD?. The abyss of despair."

func disapper():
	var boom = boom_prefab.instantiate() as Boom
	get_parent().add_child(boom)
	boom.global_position = $"Marker2D".global_position
	boom.play(Vector2.ONE * boom_size)
	$"/root/AudioManagerInstance".bgm_louder(1.5)
	input_manager.is_game_over = true
	end_label.text = "W0rld"
	queue_free()
