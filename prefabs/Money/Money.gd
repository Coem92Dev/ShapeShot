extends Node2D

@onready var global : GlobalVars = get_node("/root/Global")
@onready var colorSpr : Sprite2D = $Color
var value : int = 1
var moveto : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	if(value <= 1):
		colorSpr.modulate = global.goodBulletColor
	elif(value <= 5):
		colorSpr.modulate = global.enemyColor
	elif(value >= 25):
		colorSpr.modulate = global.BadBulletColor
	pass # Replace with function body.


func _physics_process(delta):
	if(global.player == null):
		return
	if(moveto):
		global_position = global_position.move_toward(global.player.global_position,delta*200)
		if(global_position.distance_to(global.player.global_position) < 5):
			global.money += value
			global.player.playPickSound()
			queue_free()


func _on_area_entered(_area):
	moveto = true
	
	pass # Replace with function body.
