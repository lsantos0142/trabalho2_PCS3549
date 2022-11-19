extends KinematicBody2D

var maxHp = 100
var hp = maxHp
var destroyed = false

func kill():
	if !destroyed:
		destroyed = true
		queue_free()
		Global.kill_tower()

func receive_damage(damage):
	hp -= damage
	$ProgressBar.value = hp
	if hp <= 0:
		kill()
