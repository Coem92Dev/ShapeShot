class_name GlobalVars extends Node

var baggroundColor : Color = Color("1C4548")
var goodBulletColor : Color = Color("44B899")
var playerColor : Color = Color("F6F4E6")
var enemyColor : Color = Color("FB640B")
var BadBulletColor : Color = Color("C30B0A")

var player : Node2D 
var money = 0

var spawnCounter = 0
var timer : Timer
var bossTimer : Timer
var snekTimer : Timer

var enemy = preload("res://prefabs/enemy/enemy.tscn")
var blocker = preload("res://prefabs/Blocker/blocker.tscn")
var Boss1 = preload("res://prefabs/Boss1/boss_1.tscn")
var Snek = preload("res://prefabs/Snek/snek_manager.tscn")

var blockerRNDcount = 25

var world : Node2D
var shop : Control 
var overlay : Control 
var gameOver : Control 
var resetBtn : Button

var HealthCost : int = 10
var FireRateCost : int = 10
var SpeedCost : int = 10

var dead = false
var killCounter = 0

var camera : Camera2D
var time : float = 0

func reset():
	_ready()
	HealthCost = 10
	FireRateCost = 10
	SpeedCost = 10
	dead = false
	spawnCounter = 0
	money = 0
	killCounter = 0
	time = 0
	gameOver.visible = false
	shop.visible = false
	
	unPauseGame()

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	world = get_tree().get_root().get_node("World")
	
	shop = world.get_node("CanvasLayer/Shop")
	overlay = world.get_node("CanvasLayer/Overlay")
	gameOver = world.get_node("CanvasLayer/GameOver")
	resetBtn = world.get_node("CanvasLayer/resetBtn")
	gameOver.visible = false
	shop.visible = false
	
	timer = Timer.new()
	world.add_child.call_deferred(timer)
	timer.wait_time = 1
	timer.connect("timeout",_on_timer_timeout)
	timer.autostart = true
	
	bossTimer = Timer.new()
	world.add_child.call_deferred(bossTimer)
	bossTimer.wait_time = 120
	bossTimer.connect("timeout",_on_bossTimer_timeout)
	bossTimer.autostart = true

	
	snekTimer = Timer.new()
	world.add_child.call_deferred(snekTimer)
	snekTimer.wait_time = 60
	snekTimer.connect("timeout",_on_snekTimer_timeout)
	snekTimer.autostart = true
	

	
	
func _process(delta):
	
	if(Input.is_action_just_pressed("pause")):
		togglePause()
	if(dead):
		PauseGame()
	else:
		if(!get_tree().paused):
			time += delta

func _on_timer_timeout() -> void:
	if(player == null):
		return
	spawnCounter += 1
	var e = enemy.instantiate()
	e.global_position = player.global_position+Vector2(500,0).rotated(deg_to_rad(randf()*360))
	world.add_child(e)

	if(spawnCounter > blockerRNDcount):
		var b = blocker.instantiate()
		b.global_position = player.global_position+Vector2(500,0).rotated(deg_to_rad(randf()*360))
		world.add_child(b)
		blockerRNDcount = randi_range(0,100)+spawnCounter

func _on_bossTimer_timeout() -> void:
		var b = Boss1.instantiate()
		b.global_position = player.global_position+Vector2(600,0).rotated(deg_to_rad(randf()*360))
		world.add_child(b)
		bossTimer.wait_time *= 0.95
		if(bossTimer.wait_time < 60):
			bossTimer.wait_time = 60
		
func _on_snekTimer_timeout() -> void:
		var b = Snek.instantiate()
		b.global_position = player.global_position+Vector2(600,0).rotated(deg_to_rad(randf()*360))
		world.add_child(b)
		snekTimer.wait_time = 20


func PauseGame():
	get_tree().paused = true
	if(!dead):
		shop.visible = true
	else:
		gameOver.visible = true
		resetBtn.visible = true
		

func unPauseGame():
	get_tree().paused = false
	shop.visible = false
	if(dead):
		PauseGame()


func togglePause():
	if(get_tree().paused):
		unPauseGame()
	else:
		PauseGame()

