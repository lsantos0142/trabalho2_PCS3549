extends KinematicBody2D

var speed = 900
var velocity = Vector2()
var colisoes = ["Ball", "DarkEnemy", "LightEnemy"]
var destroyed = false
var damage = 50

func _physics_process(delta):
	var collision = move_and_collide(velocity*delta)
	if collision:
		velocity = velocity.bounce(collision.normal)
		
func set_ball_direction(direction):
	velocity = direction * speed

func kill_ball():
	if !destroyed:
		destroyed = true
		queue_free()


func _on_Area2D_body_entered(body):
	if body != self:
		if "Tiro" in body.name:
			body.kill_ball()
			kill_ball()
		if ("Dark" in body.name):
			if ("Light" in name):
				body.receive_damage(damage)
				kill_ball()
		if ("Light" in body.name):
			if not ("Light" in name):
				body.receive_damage(damage)
				kill_ball()
		if ("Torre" in body.name):
			kill_ball()

func receive_damage():
	pass
