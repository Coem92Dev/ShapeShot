extends Node2D

@onready var laser = preload("res://prefabs/laserGun/Laser_gun.tscn")
@onready var global : GlobalVars = get_node("/root/Global")
@onready var colorSpr : Sprite2D = $Color



func _on_area_entered(_area):
	global.player.playPickSound()
	var gc = global.player.gun.get_child_count()
	for c in global.player.gun.get_children():
		c.queue_free()
		
	for i in range(gc):
		var l = laser.instantiate()
		global.player.gun.add_child.call_deferred(l)
	queue_free()
	
	pass # Replace with function body.
