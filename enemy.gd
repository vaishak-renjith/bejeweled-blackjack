class_name Enemy extends Node

var health = 100
var strength = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func attack():
	var chand = get_node("res://CardHand.gd")
	chand.health -= strength
	
func damage(dmg):
	health -= dmg
