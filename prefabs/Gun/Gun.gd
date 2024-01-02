class_name Gun extends Node2D

@onready var global : GlobalVars = get_node("/root/Global")
@onready var bullet = preload("res://prefabs/Bullet/bullet.tscn")
@onready var timer = $Timer
var spb :float = 1.0 
var canShoot : bool = false
@export var isEnemy: bool = false

func _ready():
	timer.wait_time = spb

func shoot():
	timer.wait_time = spb
	if(!canShoot):
		return
	timer.start()
	var b = bullet.instantiate()
	b.isBad = isEnemy
	global.world.add_child(b)
	b.global_transform = global_transform
	canShoot = false
	$AudioStreamPlayer2D.play()

	
func _on_timer_timeout():
	canShoot = true
