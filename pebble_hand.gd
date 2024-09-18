extends Node2D

@onready var texture = preload("res://icon.svg")
@onready var purple_5 = preload("res://purple5.png")

func _ready():
	draw_pebble()

var ui_dic = {}
var hboxs = []
var pebbles = []
var next_idx = 0

var can_draw = true

func update_ui(p: Pebble):
	if p.color in ui_dic.keys():
		var hbox = hboxs[ui_dic[p.color]]
		var new_textrect = TextureRect.new()
		new_textrect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE 
		new_textrect.custom_minimum_size = Vector2(32, 32) 
		new_textrect.texture = p.texture
		hbox.add_child(new_textrect)
		print("added new pebble(", p.value, ") to ", p.color, " hbox")
	else:
		ui_dic[p.color] = next_idx
		next_idx += 1
		var new_hbox = HBoxContainer.new()
		hboxs.append(new_hbox)
		var new_textrect = TextureRect.new()
		new_textrect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE 
		new_textrect.custom_minimum_size = Vector2(32, 32) 
		new_textrect.texture = p.texture
		new_hbox.add_child(new_textrect)
		$Control/VBoxContainer.add_child(new_hbox)
		print("added new ", p.color, " hbox")

func draw_pebble():
	var new_pebble = Pebble.new()
	
	var total_value = 0
	for pebble in pebbles:
		total_value += pebble.value 
	if (total_value + new_pebble.value >= 21):
		print(total_value + new_pebble.value)
		return
	var new_pebble_sprite = Sprite2D.new()
	if (new_pebble.color == "purple" and new_pebble.value == 5):
		new_pebble_sprite.texture = purple_5
	else:
		new_pebble_sprite.texture = texture
	new_pebble.texture = new_pebble_sprite.texture
	pebbles.append(new_pebble)
	update_ui(new_pebble)

func use_pebble(color, value, amount):
	var count = 0
	for pebble in pebbles:
		if pebble.color == color and pebble.value == value:
			pebbles.erase(pebble)
			for textrect in hboxs[ui_dic[color]].get_children():
				if textrect.texture.resource_path.get_file() == "purple5.png":
					hboxs[ui_dic[color]].remove_child(textrect)
			pebble.queue_free()
			count+=1
			if (count >= amount):
				return

func has_pebble(color, value):
	for pebble in pebbles:
		if pebble.color == color and pebble.value == value:
			return true
	return false

func _input(event):
	if event.as_text() == "P" and can_draw:
		draw_pebble()
		can_draw = false
		$Timer.start()
	if event.as_text() == "R":
		use_pebble("purple", 5, 1)

func _on_timer_timeout():
	can_draw = true
