extends Node2D

var menu = preload("res://Menu.tscn")
var totalTowers = 5

var remainingTowers = totalTowers

func kill_tower():
	remainingTowers -= 1
	if(remainingTowers <= 0):
		get_tree().change_scene_to(menu)
