extends MovableObj


@onready var sprite2D : AnimatedSprite2D = $"AnimatedSprite2D"
@onready var beep_player: AudioStreamPlayer2D = $"beep"
@onready var close_player: AudioStreamPlayer2D = $"close"
@onready var marker2D: Marker2D = $"Marker2D"

@export var destroy_count : int = 3
@export var current_count : int = 0
@export var wait_time : float = 8
@export var boom_size : float = 1.2
@export var is_destroy: bool = false

@export var boom_prefab: PackedScene
@export var hour_hand_prefab: PackedScene

func get_is_play():
	return sprite2D.is_playing()

func set_is_play(value: bool):
	if sprite2D.is_playing():
		if !value:
			sprite2D.stop()
			beep_player.stop()
			close_player.play()
			current_count+=1
			if current_count < destroy_count:
				wait_for_next_beep()
			else :
				var boom = boom_prefab.instantiate() as Boom
				get_parent().add_child(boom)
				boom.global_position = marker2D.global_position
				boom.play(Vector2.ONE * boom_size)
				var hour_hand = hour_hand_prefab.instantiate() as HourHand
				get_parent().add_child(hour_hand)
				hour_hand.global_position = marker2D.global_position
				is_destroy = true
				
	else:
		if value:
			sprite2D.play()
			beep_player.play()

func _ready():
	information = "An alarm clock. I hate this sound."
	set_is_play(true)


func on_click() -> bool:
	set_is_play(false)
	return is_destroy

func wait_for_next_beep():
	await get_tree().create_timer(wait_time).timeout
	set_is_play(true)
