extends KinematicBody2D

var speed = 100
var velocity = Vector2(0,0)
var hp = 100
var destroyed = false

onready var p = $"../YSort//Player"
var go = false

func kill():
	if !destroyed:
		destroyed = true
		call_deferred("free")

func _physics_process(delta):
	if go == true:
		var toPlayer = ($"../Player".position - position).normalized() 
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
	if hp <= 0:
		kill()
