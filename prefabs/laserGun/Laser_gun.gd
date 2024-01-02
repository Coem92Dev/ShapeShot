extends Node2D

@onready var global : GlobalVars = get_node("/root/Global")
@onready var explosion = preload("res://prefabs/Explosion/explosion.tscn")
@onready var area : Area2D = $Area2D
@onready var anim : AnimationPlayer = $AnimationPlayer
@onready var timer = $Timer
var spb :float = 1.0 
var spbr :float = 5.0 
var canShoot : bool = false
@export var isEnemy: bool = false

var bodies = []

func _ready():
	timer.wait_time = spbr *spb
	area.scale = Vector2.ZERO
	shoot()

func shoot():
	if(!canShoot):
		return
	timer.wait_time = spbr*spb
	if(timer.wait_time <= 0.55):
		timer.wait_time = 0.55
	timer.start()
	anim.play("OpenFire",-1,-1,true)
	canShoot = false
	$AudioStreamPlayer2D.play()

func _on_timer_timeout():
	canShoot = true

func _process(delta):
	timer.wait_time = spbr *spb
	if(anim.is_playing()):
		global.camera.shake(0.01)
		bodies = area.get_overlapping_bodies()


func _on_timer_2_timeout():
	for b in bodies:
		if(b == null):
			return
		var e = explosion.instantiate()

		e.global_position = b.global_position + Vector2(randi_range(-15,15),randi_range(-15,15))
		e.scale = Vector2.ONE * randf_range(0.1,0.2)
		e.rotation_degrees = randf_range(0,90)
		global.world.add_child(e)
		b.hurt(5)
	pass # Replace with function body.
