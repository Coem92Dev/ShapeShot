extends CharacterBody2D

const SPEED = 150
@export var live : int = 50

@onready var global : GlobalVars = get_node("/root/Global")
@onready var money = preload("res://prefabs/Money/money.tscn")

var lock = false
var target : Vector2
func _ready():
	getnewTarget()
	
func _physics_process(delta):
	if(global.player == null):
		return
	

	if(global_position.distance_to(target) < 50):
		getnewTarget()
	var v = target - global_position
	var a = v.angle()
	global_rotation = lerp_angle(global_rotation,a,2*delta)
		
	velocity = transform.x * SPEED

		
	move_and_slide()


func hurt(hitAmount : int):
	live -= hitAmount
	if(!lock):
		if(live <= 0):
			lock=true
			var moneyspawn = randi_range(20,25)
			for i in moneyspawn:
				var m = money.instantiate()
				if(randf() > 0.75):
					m.value = 5
				else:
					m.value = 1
				m.global_position = global_position + Vector2(randi_range(-15,15),randi_range(-15,15))
				m.rotation_degrees = randf_range(0,90)
				global.world.add_child.call_deferred(m)

			global.killCounter += 1
			queue_free()


func getnewTarget():
		if(global.player != null):
			target = global.player.global_position+Vector2(250,0).rotated(deg_to_rad(randf()*360))

