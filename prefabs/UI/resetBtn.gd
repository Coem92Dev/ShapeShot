extends Button

@onready var global : GlobalVars = get_node("/root/Global")
func _on_pressed():
	var scene = load("res://Scene/world.tscn").instantiate()
	get_tree().root.add_child(scene)
	global.world.name ="deadWorld"
	scene.name = "World"
	global.world.queue_free()
	global.reset()
	pass # Replace with function body.

func _on_visibility_changed():
	if(visible):
		grab_focus()
	pass # Replace with function body.
