extends MovableObj
class_name Dice

var is_rolling : bool

@export var six_count = 3
@export var need_six_count = 3
var count : int = 0

@onready var marker2D: Marker2D = $"Marker2D"
@export var boom_size : float = 1.2
@export var boom_prefab: PackedScene
@export var coin_prefab: PackedScene

func _ready():
	information = "A dice. When I grow up, I find that I can do nothing except THROW dice."

func on_throw(speed: Vector2):
	if speed.length() > 1000:
		$AnimatedSprite2D.play("roll")
		$AnimatedSprite2D.speed_scale = 5
		is_rolling = true
		for i in range(1, 10):
			$AnimatedSprite2D.speed_scale -= 5.0 /10.0 
			await get_tree().create_timer(2.0/ 10.0).timeout
		is_rolling = false
		if count < six_count :
			$AnimatedSprite2D.play(random_dice_less_6());
			count += 1			
		else:
			$AnimatedSprite2D.play("dice_6")
			count += 1
			if count >= need_six_count + six_count:
				var boom = boom_prefab.instantiate() as Boom
				get_parent().add_child(boom)
				boom.global_position = marker2D.global_position
				boom.play(Vector2.ONE * boom_size)
				var coin = coin_prefab.instantiate() as Coin
				get_parent().add_child(coin)
				coin.global_position = marker2D.global_position
				coin.information = "A coin. The dice is my job."
				queue_free()
		
	
func random_dice() -> String:
	return "dice_" + str(randi() % 6 + 1)
	
func random_dice_less_6() -> String:
	return "dice_" + str(randi() % 5 + 1)
	
	
func on_click() -> bool:
	if is_rolling:
		$AnimatedSprite2D.play(random_dice_less_6())
	return false;
