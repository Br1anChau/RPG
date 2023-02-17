extends KinematicBody2D

onready var camera = $Camera2D

var velocity = Vector2()
const PLAYER_SPEED = 200
const FRICTION = 0.5
var combat = 0


func _ready():
	pass
	
func get_input():
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 100 - combat
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
	if get_tree().get_current_scene().get_name() != "Fight":
		get_input()
		velocity.x = clamp(velocity.x, -PLAYER_SPEED, PLAYER_SPEED)
		velocity.y = clamp(velocity.y, -PLAYER_SPEED, PLAYER_SPEED)
		velocity  = move_and_slide(velocity)
	else:
		position.x = -250
		position.y = -100
