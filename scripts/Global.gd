extends Node

var current_scene = null
var isAttacking = false;
var currentEnemy = "";

var dialogues = []

func load_dialogue():
	var file = File.new()
	file.open('res://dialouge.txt', File.READ)
	var content = file.get_as_text().split('\n')
	for i in content:
		dialogues.append(i.split(';'))

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	load_dialogue()

func goto_scene(path):
	# DON'T DELETE THIS METHOD IT'S IMPORTANT!!!!!!!!!!!!!!!!!!!!!
	call_deferred("_deferred_goto_scene", path)

func _deferred_goto_scene(path):
	var previous_scene_name = current_scene.name

	# It is now safe to remove the current scene
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instance()
	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().current_scene = current_scene
	
	var portalPos = current_scene.get_node(previous_scene_name)
	if portalPos != null:
		current_scene.get_node('Player').position = portalPos.position
