extends Node2D

const WIDTH = 1000
const HEIGHT = 1000

const DARKENEMY = preload("res://DarkEnemy.tscn")
const LIGHTENEMY = preload("res://LightEnemy.tscn")

var spawnArea = Rect2()
var delta = 2
var offset = 0.5

var rng = RandomNumberGenerator.new()

func _ready():
	randomize()
	spawnArea = Rect2(0,0,WIDTH, HEIGHT)
	set_next_spawn()
	
func spawn_enemy():
	var position
	
	var rand = rng.randf_range(0.0, 10.0)
	
	if rand >= 5.0:
		if rand >= 7.5:
			position = Vector2(0, randi()%HEIGHT)
		else:
			position = Vector2(WIDTH, randi()%HEIGHT)
	else:
		if rand >= 2.5:
			position = Vector2(randi()%WIDTH, 0)
		else:
			position = Vector2(randi()%WIDTH, HEIGHT)
	
	var enemy
	if (rng.randf_range(0.0, 10.0) >= 5.0):
		enemy = DARKENEMY.instance()
	else:
		enemy = LIGHTENEMY.instance()
	
	enemy.position = position
	
	$"../YSort".add_child(enemy)
	
	return position

func _draw():
	draw_rect(spawnArea, Color(0.2,0.2, 1.0 , 0.5))

func set_next_spawn():
	var nextTime = delta + (randf()-0.5)*2*offset
	$Timer.wait_time = nextTime
	$Timer.start()

func _on_timeout():
	spawn_enemy()
	set_next_spawn()
