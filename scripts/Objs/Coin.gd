extends MovableObj
class_name Coin

@onready var raycast2D: RayCast2D = $RayCast2D

func _ready():
	information = "A coin. I'm always taught to cherish money and save it"
	
	
func on_throw(_speed: Vector2):
	if raycast2D.is_colliding() :
		var area = raycast2D.get_collider() as Node2D
		var piggy_bank = area.get_parent() as PiggyBank
		if piggy_bank != null:
			piggy_bank.add_coin()
			($"/root/AudioManagerInstance" as AudioManager).play("coin_fall")
			queue_free()


