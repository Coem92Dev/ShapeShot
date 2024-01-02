extends Area2D

var speed = 250
var lifetime = 2.0

var spinspeed = 360
@onready var global : GlobalVars = get_node("/root/Global")
@onready var explosion = preload("res://prefabs/Explosion/explosion.tscn")
@onready var timer = $Timer
@onready var spr = $Sprite2D
@export var goodColor : Color
@export var badColor : Color
var isBad : bool = false

func _ready():
	if(isBad):
		spr.modulate = badColor
		spr.z_index = 10
		collision_layer = 2
		collision_mask = 1
	else:
		spr.modulate = goodColor
		spr.z_index = -1
		collision_layer = 1
		collision_mask = 2
	timer.wait_time = lifetime
	timer.start()

func _process(delta):
	spr.rotation_degrees += spinspeed * delta
	#spinspeed += spinspeed * delta

func _physics_process(delta):
	position += transform.x * speed * delta


func _on_timer_timeout():
	queue_free()
	pass # Replace with function body.


func _on_body_entered(body):
	for i in range(randi_range(1,2)):
		var e = explosion.instantiate()
		
		e.global_position = global_position + Vector2(randi_range(-15,15),randi_range(-15,15))
		e.scale = Vector2.ONE * randf_range(0.1,0.2)
		e.rotation_degrees = randf_range(0,90)
		global.world.add_child(e)
		
	body.hurt(3)
	queue_free()
	pass # Replace with function body.
