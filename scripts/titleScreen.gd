extends Node2D
onready var button = $Button

func _ready():
	button.connect("pressed", self, "_button_pressed")
	
func _button_pressed():
	Global.goto_scene("res://scenes/Room1.tscn")
