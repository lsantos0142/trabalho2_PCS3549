extends KinematicBody2D


export var speed = 300
const BALL = preload("res://Tiro.tscn")
const BALLLIGHT = preload("res://TiroLight.tscn")
var vida = 100
var destroyed = false
var dark = false;

func _physics_process(delta):
	var input_vector = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	
	var move_direction = input_vector.normalized()
	move_and_slide(speed * move_direction)

func player():
	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if (event.position != position):
				var direction = get_local_mouse_position().normalized()
				var ball
				if dark:
					ball = BALL.instance()
				else:
					ball = BALLLIGHT.instance()
				get_parent().add_child(ball)
				ball.global_position = global_position + (50*direction)
				ball.set_ball_direction(direction)
	if event.is_action_pressed("ui_change_shot"):
		dark = !dark

