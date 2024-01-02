extends Node2D

@onready var anim : AnimationPlayer = $AnimationPlayer
@onready var global : GlobalVars = get_node("/root/Global")
# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("explosion")
	modulate = global.enemyColor
	var dist = global_position.distance_to(global.player.global_position)/100
	var power = 5.0/dist
	if(power > 5.0):
		power = 5.0
	global.camera.shake(power)
	pass # Replace with function body.




func _on_animation_player_animation_finished(_anim_name):
	queue_free()
	pass # Replace with function body.
