extends Button


@onready var sel :Sprite2D = $Pentagon/Selected
@onready var label : Label = $Pentagon/Label
@onready var global : GlobalVars = get_node("/root/Global")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	grab_focus()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label.text = str(global.HealthCost)
	pass


func _on_focus_entered():
	sel.visible = true
	pass # Replace with function body.


func _on_focus_exited():
	sel.visible = false
	pass # Replace with function body.


func _on_pressed():
	if(global.money >= global.HealthCost):
		global.money-= global.HealthCost
		global.player.live += 25
		global.HealthCost *= 2
	pass # Replace with function body.


func _on_visibility_changed():
	if(visible):
		grab_focus()
	pass # Replace with function body.
