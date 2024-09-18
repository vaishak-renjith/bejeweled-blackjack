extends Sprite2D

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if get_rect().has_point(to_local(event.position)):
			changeHand()

func changeHand():
	if (not $"../PebbleHand".visible):
		$"../PebbleHand".visible = true
		$"../CardHand".visible = false
		$"../EnemyView".visible = false
	else:
		$"../CardHand".visible = true
		$"../PebbleHand".visible = false
		$"../EnemyView".visible = true
