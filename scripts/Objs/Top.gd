extends MovableObj

@onready var animatedSprite2D : AnimatedSprite2D = $AnimatedSprite2D
@onready var raycast2D: RayCast2D = $RayCast2D
var is_rotating : bool 
var speed_record = []

@export var record_max_half_count: int = 7
@export var angle_threshold: float = 2
@export var energy_threshold: float = 80
@export var energy : float = 0

func _ready():
	information = "A top. When I was a kid, I was pretty good at SPINNING a top."



func _physics_process(delta):
	super._physics_process(delta)
	speed_record.append(linear_velocity)
	if speed_record.size() > record_max_half_count * 2 + 1 :
		speed_record.remove_at(0)
	
	if speed_record.size() == record_max_half_count * 2 + 1:
		var begin: Vector2 = speed_record[0]
		var middle: Vector2 = speed_record[record_max_half_count]
		var end: Vector2 = speed_record[2 * record_max_half_count]
		
		var angle_delta = abs((end-middle).angle_to(middle-begin))
		
		if angle_delta > angle_threshold:
			energy+=1
		else : 
			energy-=1
			
		if energy < 0 : 
			energy = 0
			
		if energy >= energy_threshold && !is_rotating:
			animatedSprite2D.play("play")
			is_rotating = true
			($"/root/AudioManagerInstance" as AudioManager).play_bgm()
			information = "A top. It seems to be rotating in REVERSE."
	

func on_throw(_speed: Vector2):
	if is_rotating:
		if raycast2D.is_colliding() :
			var area = raycast2D.get_collider() as Node2D
			var the_world = area.get_parent() as TheWorld
			if the_world != null:
				if the_world.is_flip :
					the_world.reverse()
					($"/root/AudioManagerInstance" as AudioManager).play("card_reverse")
					queue_free()
