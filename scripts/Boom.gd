extends Node2D
class_name Boom

@onready var animatedSprite2D: AnimatedSprite2D = $AnimatedSprite2D
@onready var audioStreamPlayer2D: AudioStreamPlayer2D = $AudioStreamPlayer2D



func play(size: Vector2):
	scale = size
	animatedSprite2D.play()
	audioStreamPlayer2D.play()
	animatedSprite2D.animation_finished.connect(
		queue_free
	)
