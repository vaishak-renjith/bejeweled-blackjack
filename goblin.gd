extends Enemy

func _ready():
	health = 50
	strength = 5
	print("goblin", health)

func _process(delta):
	if can_move:
		attack()
