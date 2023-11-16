extends MovableObj
class_name TheHighPriestess

@onready var animation_player : AnimationPlayer = $AnimationPlayer
var is_flip : bool 


func _ready():
	information = "A tarot card. What card is this?"
	is_flip = false

func on_throw(speed: Vector2):
	if(!is_flip && abs(speed.x) > 900):
		animation_player.play("flip")
		is_flip = true
		information = "THE HIGH PRIESTESS. The person on the card is like my Mother."
