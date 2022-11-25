extends KinematicBody2D

var speed = 100
var velocity = Vector2(0,0)
var originalHp = 100
var hp = originalHp
var destroyed = false
onready var area = $Area2D
onready var area2 = $Range
var ClosestObject = null
var delta = 2
var offset = 0.5
var go = false

onready var enemy_spawner = get_node("/root/Mundo/EnemySpawner")

func _ready():
	set_next_attack()

func kill():
	if !destroyed:
		enemy_spawner.set_enemy_kills(enemy_spawner.enemy_kills + 1)
		destroyed = true
		queue_free()

func _physics_process(delta):
	if go == true:
		var toPlayer
		var AvailableItems = area.get_overlapping_bodies()
		
		var Array_ = []
		var ArrayPosition: int = -1
		Array_.resize(AvailableItems.size())
		
		for element in AvailableItems:
			var Distance = element.global_transform.origin.distance_to(global_transform.origin)
			
			ArrayPosition += 1
			Array_[ArrayPosition] = Distance
			
		for element in AvailableItems:
			var Distance = element.global_transform.origin.distance_to(global_transform.origin)
			if Distance == Array_.min():
				ClosestObject = element
				toPlayer = (element.position - position).normalized() 
		velocity = toPlayer*speed
		move_and_collide(velocity * delta)

func _on_Area2D_body_entered(body):
	if body.has_method("player"):
		go = true


func _on_Area2D_body_exited(body):
	if body.has_method("player"):
		go = false
		velocity = Vector2(0,0)
	
func receive_damage(damage):
	hp -= damage
	$ProgressBar.value = hp
	if hp <= 0:
		kill()

func damage():
	pass

func set_next_attack():
	var nextTime = delta + (randf()-0.5)*2*offset
	$Timer.wait_time = nextTime
	$Timer.start()

func _on_Timer_timeout():
	set_next_attack()

	for element in area2.get_overlapping_areas():
		if ClosestObject.name in element.get_parent().name:
			ClosestObject.receive_damage(5)
