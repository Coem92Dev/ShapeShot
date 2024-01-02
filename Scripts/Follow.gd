extends Node2D

@export var target : Node2D
@export var speed : float = 100
@export var lockOn : bool = true
@export var offset : Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(lockOn):
		global_position = target.global_position + offset
		return
		
	global_position = global_position.lerp(target.global_position + offset,speed*delta)
	
	
	pass
