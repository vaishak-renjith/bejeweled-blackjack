extends Node2D

var enemies = [preload("res://goblin.tscn"),
preload("res://imp.tscn")]

var cur_enemy = enemies.pick_random().instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(cur_enemy)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (cur_enemy.health <= 0):
		remove_child(cur_enemy)
		cur_enemy = enemies.pick_random().instantiate()
		add_child(cur_enemy)
	
func get_enemy():
	return cur_enemy
