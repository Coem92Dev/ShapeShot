extends Node2D

@onready var laser = preload("res://prefabs/laserGun/Laser_gun.tscn")
@onready var global : GlobalVars = get_node("/root/Global")
@onready var colorSpr : Sprite2D = $Color



func _on_area_entered(_area):
	global.player.playPickSound()
	
	var fc = global.player.gun.get_child(0)
	
	var f1 = fc.duplicate()
	var f2 = fc.duplicate()
	f1.canShoot = true
	f2.canShoot = true
	global.player.gun.add_child.call_deferred(f1)
	global.player.gun.add_child.call_deferred(f2)

	queue_free()
	
	pass # Replace with function body.
