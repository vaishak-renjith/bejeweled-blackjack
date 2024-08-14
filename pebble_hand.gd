extends Node2D

@onready var texture = preload("res://icon.svg")

func _ready():
	draw_pebble()

var ui_dic = {}
var hboxs = []
var next_idx = 0

var can_draw = true

func update_ui(p: Pebble):
	# if pebble color in ui_dic.keys()
		# add new texturerect to the hboxcontainer for that color
	# else 
		# create new hboxcontainer for that color 
		# add new texturerect to the new hboxcontainer for that color
	if p.color in ui_dic.keys():
		var hbox = hboxs[ui_dic[p.color]]
		var new_textrect = TextureRect.new()
		new_textrect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE 
		new_textrect.custom_minimum_size = Vector2(32, 32) 
		new_textrect.texture = p.texture
		hbox.add_child(new_textrect)
		print("added new pebble to ", p.color, " hbox")
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
	print(new_pebble.color)
	print(new_pebble.value)
	var new_pebble_sprite = Sprite2D.new()
	new_pebble_sprite.texture = texture
	new_pebble.texture = new_pebble_sprite.texture
	update_ui(new_pebble)

func _input(event):
	if event.as_text() == "P" and can_draw:
		draw_pebble()
		can_draw = false
		$Timer.start()

func _on_timer_timeout():
	can_draw = true
