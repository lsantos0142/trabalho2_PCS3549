extends Node2D

const WIDTH = 2000
const HEIGHT = 2000

const DARKENEMY = preload("res://DarkEnemy.tscn")
const LIGHTENEMY = preload("res://LightEnemy.tscn")

onready var day_started_text = get_node("/root/HUD/DayStarted")
onready var day_ended_text = get_node("/root/HUD/DayEnded")

onready var torre1 := $"../YSort/Torre"
onready var torre2 := $"../YSort/Torre2"
onready var torre3 := $"../YSort/Torre3"
onready var torre4 := $"../YSort/Torre4"
onready var torre5 := $"../YSort/Torre5"

var spawnArea = Rect2()
var delta = 2
var offset = 0.5

var enemy_count = 0
var enemies_per_round = 2
var round_count = 1

export var enemy_kills = 0 setget set_enemy_kills

func set_enemy_kills(new_enemy_kills):
	enemy_kills = new_enemy_kills

onready var roundTimer := $RoundTimer
onready var spawnTimer := $SpawnTimer
onready var dayStartedTimer := $DayStartedTimer
onready var dayEndedTimer := $DayEndedTimer

var rng = RandomNumberGenerator.new()

func _ready():
	randomize()
	spawnArea = Rect2(0,0,WIDTH, HEIGHT)
	set_next_spawn()
	day_started_text.show()
	dayStartedTimer.wait_time = 3
	dayStartedTimer.start()
	
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
	
	enemy_count += 1
	
	return position

func set_next_spawn():
	var nextTime = delta + (randf()-0.5)*2*offset
	spawnTimer.wait_time = nextTime
	spawnTimer.start()

func _on_timeout():
	if (enemy_count < enemies_per_round):	
		spawn_enemy()
		set_next_spawn()
		
func _process(delta):
	if (enemy_kills == enemies_per_round):
		
		
		enemy_kills = 0
		print("Round ", round_count, " finalizado!")
		day_ended_text.text = "Dia " + str(round_count) + " finalizado!"
		day_ended_text.show()
		dayEndedTimer.wait_time = 3
		dayEndedTimer.start()
		round_count += 1 
		roundTimer.wait_time = 7
		roundTimer.start()
		
		

		if (is_instance_valid(torre1)):
			torre1.restore_hp()
		if (is_instance_valid(torre2)):
			torre2.restore_hp()
		if (is_instance_valid(torre3)):
			torre3.restore_hp()
		if (is_instance_valid(torre4)):
			torre4.restore_hp()
		if (is_instance_valid(torre5)):
			torre5.restore_hp()
		
func _on_RoundTimer_timeout():
	print("Iniciando Round ", round_count)
	day_started_text.text = "Dia " + str(round_count)
	day_started_text.show()
	dayStartedTimer.wait_time = 3
	dayStartedTimer.start()
	roundTimer.stop()
	if (delta > 0.6):
		delta -= 0.1
	enemy_count = 0
	enemies_per_round += 2
	
func _on_DayStartedTimer_timeout():
	day_started_text.hide()
	dayStartedTimer.stop()
	
func _on_DayEndedTimer_timeout():
	day_ended_text.hide()
	dayEndedTimer.stop()


func receive_damage():
	pass
	

