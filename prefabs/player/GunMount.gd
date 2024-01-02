extends Node2D

var fireInterval = 1

func setFireInterval(val):
	fireInterval = val
	for c in get_children():
		c.spb = fireInterval

func shoot():
	for c in get_children():
		c.shoot()
		
func _process(delta):
	arrange()

func arrange():
	if(get_child_count()>0):
		var tangle = 15*(get_child_count()-1)
		var i = 0
		for c : Node2D in get_children():
			c.rotation_degrees = 15*i-(tangle)/2
			i += 1
	pass
