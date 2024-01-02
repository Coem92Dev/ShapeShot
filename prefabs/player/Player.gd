extends CharacterBody2D

var SPEED = 100.0

@export var live = 100


@onready var global : GlobalVars = get_node("/root/Global")
@onready var emitter : CPUParticles2D = $CPUParticles2D
@onready var gun = $GunMount

var joyinput :Vector2
var canShoot : bool = true
var firerate = 0.6

var useContoller = false

func _ready():
	global.player = self
	gun.setFireInterval(firerate)

func _physics_process(_delta):
	gun.setFireInterval(firerate)
	if(useContoller):
		joyinput = Input.get_vector("lookLeft", "lookRight", "lookUp", "lookDown")
		if(joyinput.length() > 0.01):
			global_rotation = joyinput.angle()
			gun.shoot()
	else:
		look_at(get_global_mouse_position())
	

	
	if (Input.is_action_pressed("shoot")):
		gun.shoot()
	
	var move_input = Input.get_axis("down", "up")
	var straif_input = Input.get_axis("left", "right")
	
	velocity.y = move_input * -SPEED
	velocity.x = straif_input * SPEED
	if(velocity.length_squared() > 0.2):
		emitter.emitting = true
		emitter.lifetime = 1
	else:
		emitter.emitting = false
		emitter.lifetime = 0.25
	
	move_and_slide()


func hurt(hitAmount : int):
	live -= hitAmount
	global.camera.shake(5.0)
	if(live <= 0):
		global.dead = true
		queue_free()
		
func playPickSound():
	$AudioStreamPlayer.play()
	
func _input(event):
	if event is InputEventJoypadMotion:
		
		useContoller = true
	if event is InputEventMouseMotion:
		useContoller = false

