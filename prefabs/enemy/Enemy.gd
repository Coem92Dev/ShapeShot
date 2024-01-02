extends CharacterBody2D

const SPEED = 25.0

@export var live : int = 5

@onready var global : GlobalVars = get_node("/root/Global")
@onready var money = preload("res://prefabs/Money/money.tscn")
@onready var emitter : CPUParticles2D = $CPUParticles2D
@onready var gun = $Gun

var lock = false


func _physics_process(_delta):
	if(global.player == null):
		return
	look_at(global.player.global_position)
	
	if(global_position.distance_to(global.player.global_position) > 150):
		velocity = transform.x * SPEED
		emitter.emitting = true
		emitter.lifetime = 1
	else:
		velocity = transform.y * SPEED
		emitter.emitting = false
		emitter.lifetime = 0.25
		gun.spb = 3
		gun.shoot()
	move_and_slide()
	
	if(global_position.distance_to(global.player.global_position) > 2000):
		queue_free()

func hurt(hitAmount : int):
	live -= hitAmount
	if(!lock):
		if(live <= 0):
			lock=true
			var moneyspawn = randi_range(1,5)
			for i in moneyspawn:
				var m = money.instantiate()
				m.value = 1
				m.global_position = global_position + Vector2(randi_range(-15,15),randi_range(-15,15))
				m.rotation_degrees = randf_range(0,90)
				global.world.add_child.call_deferred(m)

			global.killCounter += 1
			queue_free()

