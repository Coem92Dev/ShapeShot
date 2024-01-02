extends CharacterBody2D

const SPEED = 200
@export var live : int = 5

@onready var global : GlobalVars = get_node("/root/Global")
@onready var money = preload("res://prefabs/Money/money.tscn")
@onready var gun = $Turret/gun
@onready var turret = $Turret

var lock = false
var target : Node2D

func _ready():
	pass
	
func _physics_process(delta):

		
		
	if(turret != null):
		if(global_position.distance_to(global.player.global_position) < 300):

			turret.look_at(global.player.global_position)
			gun.spb = 2+randf()
			gun.shoot()
			
	if(global.player == null):
		return
	if(target == null):
		return	
	var v = target.global_position - global_position
	var a = v.angle()
	global_rotation = lerp_angle(global_rotation,a,10*delta)
		
	if(global_position.distance_to(target.global_position )> 20):
		velocity = transform.x * SPEED
	else:
		velocity = transform.x * SPEED/2
	move_and_slide()


func hurt(hitAmount : int):
	live -= hitAmount
	if(!lock):
		if(live <= 0):
			lock=true
			var moneyspawn = randi_range(1,3)
			for i in moneyspawn:
				var m = money.instantiate()
				m.value = 1
				m.global_position = global_position + Vector2(randi_range(-15,15),randi_range(-15,15))
				m.rotation_degrees = randf_range(0,90)
				global.world.add_child.call_deferred(m)

			global.killCounter += 1
			queue_free()

