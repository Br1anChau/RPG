extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var enemyLoad = preload("res://scenes/Enemy.tscn")
onready var attackButtonLoad = preload("res://scenes/AttackButton.tscn")
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	var numOfEnemies = rng.randi_range(1, 3)
	print(numOfEnemies)
	
	for n in numOfEnemies:
		var enemyNum = str(n)
		var enemy = enemyLoad.instance()
		enemy.set_name("enemy" + enemyNum)
		add_child(enemy)
		enemy.position.x = 250
		if(n == 0):
			enemy.position.y = -150
			print(enemy.position.y)
		if(n == 1):
			enemy.position.y = -250
			print(enemy.position.y)
		if(n == 2):
			enemy.position.y = -50
			print(enemy.position.y)
	var button = attackButtonLoad.instance()
#	button.set_name("button 1")
#	button.setText("enemy1")
#	add_child(button)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
