extends RigidBody2D
class_name MovableObj

@export var friction_factor: float = 10
@export var velocity_threshold: float = 10
@export var information: String = "this is a apple"


func set_order(order: int):
	z_index = order

func _physics_process(_delta):
	if linear_velocity.length() < velocity_threshold :
		linear_velocity = Vector2.ZERO
	else :
		var new_linear_velocity = linear_velocity - linear_velocity.normalized() * friction_factor * friction_factor
		var x : float = new_linear_velocity.x 
		if linear_velocity.x * new_linear_velocity.x < 0 :
			x = max(new_linear_velocity.x, 0)
		var y : float = new_linear_velocity.y
		if linear_velocity.y * new_linear_velocity.y < 0 :
			y = max(new_linear_velocity.y, 0)
		linear_velocity = Vector2(x, y)
		
		
