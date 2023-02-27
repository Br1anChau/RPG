extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var originalX = 250
var originalY = 0
var gracePeriod = 2
var health = 0
var timer = 0
var cooldown = 0
var rng = RandomNumberGenerator.new()
var velocity = Vector2(0,0)
var attacking = false
var returning = false
var striking = false
var spearLoad = preload("res://scenes/spear.tscn")
var striked = false
var spawnSpear = false
var spearTimer = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	originalY = self.position.y
	rng.randomize()
	health = rng.randi_range(1, 5)
	timer = rng.randf_range(3.1, 5.2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.x = 0
	velocity.y = 0
	if(cooldown > timer && !Global.enemyAttacking):
		attacking = true
	Global.duration += 0.1
	if(Global.targetEnemy == self.name && Global.goingBack): 
		health -= 5
		if(health < 1):
			self.queue_free()
	if(cooldown < timer && !Global.enemyAttacking):
		cooldown += 0.05
		print(cooldown)

	if(abs(self.position.x - Global.playerX) < 100 && !returning):		
		returning = true
		striking = true
		

	if(attacking && !Global.justAttacked && gracePeriod < Global.duration ):
		Global.enemyAttacking = true
		if(!returning):
			velocity.y -= (self.position.y - Global.playerY) * 1.5
			velocity.x -= (self.position.x - Global.playerX)
			velocity = move_and_slide(velocity)
			attacking = true
			Global.enemyAttacking = true
		elif(returning && striking):
			if(!spawnSpear):
				var spear = spearLoad.instance()
				spear.set_name("spear")
				self.add_child(spear)
				spear.position.x = self.position.x
				spear.position.y = self.position.y
				spawnSpear = true
			if(striked == false):
				self.get_node("spear").animationPlayer.play("Swing")
				striked = true
			else:
				spearTimer += 0.05
				print(spearTimer)
			if(spearTimer > 2.5):
				striking = false
				returning = true
				striked = false
				spawnSpear = false
				self.get_node("spear").queue_free()
				spearTimer = 0
		else: 
			if(abs(self.position.y - originalY) < 10 && abs(self.position.x - originalX) < 10):
				returning = false
				Global.enemyAttacking = false
				attacking = false
				Global.duration = 0
				cooldown = 0
			if(abs(self.position.y - originalY) > 0.0001):
				velocity.y += (originalY - self.position.y) * 1.5
			if(abs(self.position.x - originalX) > 0.0001):
				velocity.x += (originalX - self.position.x) * 2
			velocity = move_and_slide(velocity)
		
	

func _on_Area2D_body_entered(body):
	if(body != self && body.name != "Spear"):
		health -= 5
		if(health < 1):
			self.queue_free()
	pass # Replace with function body.
