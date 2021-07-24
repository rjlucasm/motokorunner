extends Node

var current_scene = null

var node_creation_parent = null
var player = null

var score = 0

var file = File.new()

var bestscore = 0 setget set_bestscore

var filepath = "user://bestscore.data"

func instance_node(node, location, parent):
	var node_instance = node.instance()
	parent.add_child(node_instance)
	node_instance.global_position = location
	return node_instance

func create_save():
   file.open(filepath, File.WRITE)
   file.store_var(bestscore)
   file.close()

func _ready():
	if not file.file_exists(filepath):
		create_save()
	
	load_bestscore()
	
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func load_bestscore():
	#if not file.file_exists(filepath): return
	file.open(filepath, File.READ)
	bestscore = file.get_var()
	file.close()
	
func save_bestscore():
	file.open(filepath, File.WRITE)
	file.store_var(bestscore)
	file.close()

func set_bestscore(new_value):
	bestscore = new_value
	save_bestscore()


func goto_scene(path):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:

	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	# It is now safe to remove the current scene
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instance()

	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)
