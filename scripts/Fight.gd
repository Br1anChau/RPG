extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var enemyLoad = preload("res://scenes/EnemyInCombat.tscn")
onready var attackButtonLoad = preload("res://scenes/AttackButton.tscn")
var rng = RandomNumberGenerator.new()

var buttonList = []
var timeWaited = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
#	var numOfEnemies = rng.randi_range(1, 3)
	var numOfEnemies = 3
	print(numOfEnemies)
	
	for n in numOfEnemies:
		var enemyNum = str(n)
		var enemy = enemyLoad.instance()
		var attackButton = attackButtonLoad.instance()
		enemy.set_name("enemy" + enemyNum)
		attackButton.get_node("Button").text = enemy.name
		attackButton.name = "button " + enemy.name 
		add_child(enemy)
		add_child(attackButton)
		buttonList.append(attackButton)
		enemy.position.x = 250
		attackButton.rect_position.x = -250
		if(n == 0):
			enemy.position.y = -50
			enemy.originalY = -50
			attackButton.rect_position.y = 10
		if(n == 1):
			enemy.position.y = -150
			enemy.originalY = -150
			attackButton.rect_position.y = 30
		if(n == 2):
			enemy.position.y = -250
			enemy.originalY = -250
			attackButton.rect_position.y = 50
#	button.set_name("button 1")
#	button.setText("enemy1")
#	add_child(button)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(buttonList.size() == 0 && Global.justAttacked == false):
		Global.isAttacking = false
		Global.goto_scene("res://scenes/" + name + ".tscn")
	if(Global.justAttacked):
		for n in buttonList:
			n.visible = false
		timeWaited = 0
	elif(timeWaited >= Global.cooldown):
		for n in buttonList:
			n.visible = true
	else:
		timeWaited += 0.1
		print("increasing")
	if(Global.targetEnemy != null && !has_node(Global.targetEnemy)):
		var index = buttonList.find(self.get_node("button " + Global.targetEnemy), 0)
		if(index != -1):
			buttonList.remove(index)
	elif(Global.targetEnemy != null && has_node(Global.targetEnemy)):
		Global.targetX = get_node(Global.targetEnemy).position.x
		Global.targetY = get_node(Global.targetEnemy).position.y		
