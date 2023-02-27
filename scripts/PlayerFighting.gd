extends KinematicBody2D


var velocity = Vector2()
var originalX = -200
var originalY = -100
var baseSpeed = 10
onready var animatedSprite = $AnimatedSprite
onready var swordLoad = preload("res://scenes/Sword.tscn")
var SwordTimer = 0;
var swung = false;
var spawnSword = false;
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.x = 0
	velocity.y = 0
	print(Global.isAttacking)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Global.targetEnemy != null):
		Global.justAttacked = true
		velocity = Vector2(0,0)
		if(abs(self.position.x - Global.targetX) < 50 && !Global.goingBack):
			Global.swingingSword = true
		if(!Global.goingBack && !Global.swingingSword && !Global.enemyAttacking):
			velocity.y -= (self.position.y - Global.targetY) * 1.5 
			velocity.x -= (self.position.x - Global.targetX) 
			velocity  = move_and_slide(velocity)
			animatedSprite.play("Walking Right")
		elif(Global.swingingSword && !Global.goingBack):
			if(!spawnSword):
				var sword = swordLoad.instance()
				self.animatedSprite.play("Idle")
				sword.set_name("Sword")
				add_child(sword)
				sword.position.x = self.position.x
				sword.position.y = self.position.y
				spawnSword = true
			if(swung == false):
				self.get_node("Sword").animationPlayer.play("Swing")
				swung = true
			else:
				SwordTimer += 0.05
			print(SwordTimer)
			if(SwordTimer > 2.5):
				Global.swingingSword = false
				Global.goingBack = true
				swung = false
				spawnSword = false
				self.get_node("Sword").queue_free()
				SwordTimer = 0
		else:
			print(self.position.y)
			print(originalY)
			if(abs(self.position.y - originalY) < 10 && abs(self.position.x - originalX) < 10):
				Global.goingBack = false
				Global.targetEnemy = null
				Global.justAttacked = false
				animatedSprite.play("Idle")
			else:
				if(self.position.y != originalY):
					velocity.y += (originalY - self.position.y) * 5
				if(self.position.x != originalX):
					velocity.x -= (self.position.x - originalX) + 5
				velocity  = move_and_slide(velocity)
				animatedSprite.play("Walking Left")
			
