extends Button


@onready var sel :Sprite2D = $Pentagon/Selected
@onready var label : Label = $Pentagon/Label
@onready var global : GlobalVars = get_node("/root/Global")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label.text = str(global.FireRateCost)
	pass


func _on_focus_entered():
	sel.visible = true
	pass # Replace with function body.


func _on_focus_exited():
	sel.visible = false
	pass # Replace with function body.


func _on_pressed():
	if(global.money >= global.FireRateCost):
		global.money -= global.FireRateCost
		global.player.firerate *= 0.8
		global.FireRateCost *= 1.8
	pass # Replace with function body.
