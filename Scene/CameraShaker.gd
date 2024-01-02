extends Camera2D
@onready var global : GlobalVars = get_node("/root/Global")
@export var fade : float = 5.0

var rng = RandomNumberGenerator.new()
var shake_strengh: float = 0.0

func _ready():
	global.camera = self

# Called when the node enters the scene tree for the first time.
func shake(val):
	shake_strengh += val
	if(shake_strengh > 20):
		shake_strengh = 20
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(shake_strengh > 0):
		shake_strengh = lerpf(shake_strengh,0,fade*delta)
	
	offset = rngOffset()
	pass

func rngOffset() -> Vector2:
	var x = rng.randf_range(-shake_strengh,shake_strengh)
	var y = rng.randf_range(-shake_strengh,shake_strengh)
	return Vector2(x,y)
