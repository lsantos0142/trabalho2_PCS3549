extends Control

onready var timer := $Timer
onready var day_started_text = get_node("/root/HUD/DayStarted")

func _on_TextureButton_pressed():
	get_tree().change_scene("res://Mundo.tscn")
