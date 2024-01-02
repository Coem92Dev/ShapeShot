extends CharacterBody2D

const SPEED = 50.0

@export var live : int = 75

@onready var global : GlobalVars = get_node("/root/Global")
@onready var money = preload("res://prefabs/Money/money.tscn")
@onready var emitter : CPUParticles2D = $CPUParticles2D

var lock = false


func _physics_process(_delta):
	if(global.player == null):
		return
	look_at(global.player.global_position)
	
	if(global_position.distance_to(global.player.global_position) > 100):
		velocity = transform.x * SPEED
		emitter.emitting = true
		emitter.lifetime = 1
	else:
		velocity = transform.y * SPEED
		emitter.emitting = false
		emitter.lifetime = 0.25

	move_and_slide()


func hurt(hitAmount : int):
	live -= hitAmount
	if(!lock):
		if(live <= 0):
			lock=true

			var m = money.instantiate()
			m.value = 5
			m.global_position = global_position + Vector2(randi_range(-15,15),randi_range(-15,15))
			m.rotation_degrees = randf_range(0,90)
			global.world.add_child.call_deferred(m)

			global.killCounter += 1
			queue_free()

