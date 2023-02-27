extends Node2D

var health = 0
var timer = 0
var cooldown = 0
var rng = RandomNumberGenerator.new()
var velocity = Vector2()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	health = rng.randi_range(1, 5)
	timer = rng.randf_range(0.9, 1.3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_Area2D_body_entered(body):
	if(body != self):
		Global.goto_scene("res://scenes/Fight.tscn")
		self.queue_free()
		
