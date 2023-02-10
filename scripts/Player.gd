extends KinematicBody2D

var velocity = Vector2()
const PLAYER_SPEED = 200
const FRICTION = 0.5


func _ready():
	pass # Replace with function body.

func get_input():
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 100
	if Input.is_action_pressed('ui_down'):
		velocity.y += 100
	if not (Input.is_action_pressed('ui_up') || Input.is_action_pressed('ui_down')):
		velocity.y *= FRICTION
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 100
	if Input.is_action_pressed('ui_right'):
		velocity.x += 100
	if not (Input.is_action_pressed('ui_left') || Input.is_action_pressed('ui_right')):
		velocity.x *= FRICTION

func _process(delta):
	if velocity.length() > 10:
		z_index = position.y
	get_input()
	velocity.x = clamp(velocity.x, -PLAYER_SPEED, PLAYER_SPEED)
	velocity.y = clamp(velocity.y, -PLAYER_SPEED, PLAYER_SPEED)
	velocity  = move_and_slide(velocity)
