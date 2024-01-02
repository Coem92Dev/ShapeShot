extends Node2D


@onready var prehead = preload("res://prefabs/Snek/snek.tscn")
@onready var prepart = preload("res://prefabs/Snek/snek_part.tscn")
@onready var pregun = preload("res://prefabs/Snek/snek_gun.tscn")

var head
var selfkill = false
# Called when the node enters the scene tree for the first time.
func _ready():
	spawn()
	pass # Replace with function body.

func _process(delta):

	if(selfkill):
		if(head == null):
			queue_free()

func spawn():

	head = prehead.instantiate()
	add_child(head)
	var last = head
	for i in range(randi_range(3,10)):
		if(randf() > 0.75):
			var part = pregun.instantiate()
			part.target = last
			last = part
			add_child(part)
		else:
			var part = prepart.instantiate()
			part.target = last
			last = part
			add_child(part)
		
	selfkill = true
