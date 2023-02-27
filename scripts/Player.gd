extends KinematicBody2D

var interacting = null
var typing = false
var index = 0

onready var camera = $Camera2D
onready var animatedSprite = $AnimatedSprite

onready var textBox = $Camera2D/TextBox
onready var npcName = $Camera2D/Name
onready var content = $Camera2D/Content
onready var inventory = $Camera2D/inventory
onready var moneyCount = $Camera2D/inventory/MoneyCount

var velocity = Vector2()
const PLAYER_SPEED = 200
const FRICTION = 0.5


func _ready():
	pass # Replace with function body.

func get_input():
	if(!typing):
		if Input.is_action_pressed('ui_up'):
			velocity.y -= 100
		if Input.is_action_pressed('ui_down'):
			velocity.y += 100
		if not (Input.is_action_pressed('ui_up') || Input.is_action_pressed('ui_down')):
			velocity.y *= FRICTION
		if Input.is_action_pressed('ui_left'):
			velocity.x -= 100
			animatedSprite.play("Walking Left")
		if Input.is_action_pressed('ui_right'):
			velocity.x += 100
			animatedSprite.play("Walking Right")
		if not (Input.is_action_pressed('ui_left') || Input.is_action_pressed('ui_right')):
			velocity.x *= FRICTION

func _process(delta):
	if velocity.length() > 10:
		z_index = position.y
	get_input()
	velocity.x = clamp(velocity.x, -PLAYER_SPEED, PLAYER_SPEED)
	velocity.y = clamp(velocity.y, -PLAYER_SPEED, PLAYER_SPEED)
	if(velocity.x <= 0 && velocity.y <= 0):
		animatedSprite.play("Idle")
	velocity  = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("interact"):
		if interacting != null:
			textBox.visible = true
			npcName.visible = true
			content.visible = true
			npcName.text = interacting.name
			if(!typing):
				for i in Global.dialogues.size():
					if(Global.dialogues[i][0] == npcName.text):
						index = i
						break
				typing = true
			if(Global.dialogues[index][1] == "finished"):
				interacting == null
				textBox.visible = false
				npcName.visible = false
				content.visible = false
				typing = false
				index = 0
			else:
				content.text = Global.dialogues[index][1]
				index = index +1 
	
	if Input.is_action_just_pressed("Open_inventory"):
		inventory.visible = !inventory.visible
		moneyCount = PlayerVariables.counter
		
