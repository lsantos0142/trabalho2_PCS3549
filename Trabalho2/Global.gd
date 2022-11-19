extends Node

var menu = preload("res://Menu.tscn")
var totalTowers = 5

var remainingTowers = totalTowers

func kill_tower():
	remainingTowers -= 1
	print(remainingTowers)
	if(remainingTowers <= 0):
		get_tree().change_scene_to(menu)
		remainingTowers = totalTowers
