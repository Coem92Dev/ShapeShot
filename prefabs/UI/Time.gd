extends Label

@onready var global : GlobalVars = get_node("/root/Global")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "survived for: %d:%02d" % [floor(global.time / 60), int(global.time) % 60]
	pass
