extends Button


@onready var sel :Sprite2D = $Pentagon/Selected
@onready var label : Label = $Pentagon/Label
@onready var global : GlobalVars = get_node("/root/Global")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label.text = str(global.SpeedCost)
	pass


func _on_focus_entered():
	sel.visible = true
	pass # Replace with function body.


func _on_focus_exited():
	sel.visible = false
	pass # Replace with function body.


func _on_pressed():
	if(global.money >= global.SpeedCost):
		global.money -= global.SpeedCost
		global.player.SPEED += 25.0
		global.SpeedCost *= 2.3
	pass # Replace with function body.
