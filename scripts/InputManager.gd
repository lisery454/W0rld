extends Node2D
class_name InputManager

@onready var raycast2D: RayCast2D = $RayCast2D
@export var info_label: Label

var current_obj : MovableObj = null
var current_drag_obj : MovableObj = null
var drag_z_index: int = 1
@export var speed_factor: float = 20
@export var max_speed: float = 100
var last_mouse_pos : Vector2 = Vector2.ZERO
var is_game_over : bool = false;

func is_dragging() -> bool :
	return current_drag_obj != null


func _process(_delta):
	if is_game_over:
		info_label.text = "thanks for playing."
	else :
		if current_obj != null :
			info_label.text = current_obj.information
		else :
			info_label.text = ""

func _physics_process(_delta):
	# update ray pos
	var mouse_pos:Vector2 = get_viewport().get_mouse_position()
	raycast2D.position = mouse_pos
	
	if mouse_pos != last_mouse_pos :
		if !is_dragging() :
			if raycast2D.is_colliding() :
				var obj = raycast2D.get_collider() as MovableObj
				current_obj = obj
			else :
				current_obj = null
		else :
			var window_size = get_viewport().get_visible_rect().size	
			if mouse_pos.x < window_size.x && mouse_pos.x > 0 && \
				mouse_pos.y < window_size.y && mouse_pos.y > 0:
					var distance = current_drag_obj.position.distance_to(mouse_pos)
					var direction = current_drag_obj.position.direction_to(mouse_pos)
					var speed = min(distance * speed_factor, max_speed)
					current_drag_obj.linear_velocity = direction * speed
			
		
	last_mouse_pos = mouse_pos
		
		
func _input(event):
	var e := event as InputEventMouseButton
	if e != null:
	
		if e.is_pressed() && e.button_index == MOUSE_BUTTON_LEFT:
			on_left_mouse_down()
		
		if e.is_released() && e.button_index == MOUSE_BUTTON_LEFT:
			on_left_mouse_up()
		
		
func on_left_mouse_up():
	if is_dragging():
		if current_drag_obj.has_method("on_throw"):
			current_drag_obj.call("on_throw", current_drag_obj.linear_velocity)
		current_drag_obj = null
	
		
func on_left_mouse_down():
	if !is_dragging() && current_obj != null:
		current_drag_obj = current_obj
		current_drag_obj .set_order(drag_z_index)	
		drag_z_index += 1
		
		if current_obj.has_method("on_click"):
			var isDestroy: bool = current_obj.call("on_click")
			if isDestroy:
				current_obj.queue_free()
				current_obj = null
				current_drag_obj = null
			
		
		
	
	
	
	
