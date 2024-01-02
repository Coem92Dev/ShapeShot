extends Sprite2D

@export var target : Node2D
# Called when the node enters the scene tree for the first time.
func _ready():
	z_index = -10
	self_modulate = Color.BLACK
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	transform = target.transform
	global_position = target.global_position + Vector2(3,3)
	pass
