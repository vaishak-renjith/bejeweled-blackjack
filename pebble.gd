class_name Pebble extends Node2D

var color
var value
var texture

var random_colors = ["red", "green", "blue", "yellow", "black", "purple"]

var random_values = [1, 3, 5]
var rng = RandomNumberGenerator.new()

func _init():
	color = random_colors.pick_random()
	value = random_values.pick_random()
