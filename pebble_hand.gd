extends Node2D

@onready var texture = preload("res://icon.svg")
@onready var purple_5 = preload("res://purple5.png")
@onready var purple_3 = preload("res://purple3.png")
@onready var purple_1 = preload("res://purple1.png")
@onready var red_5 = preload("res://red5.png")
@onready var red_3 = preload("res://red3.png")
@onready var red_1 = preload("res://red1.png")
@onready var yellow_5 = preload("res://yellow5.png")
@onready var yellow_3 = preload("res://yellow3.png")
@onready var yellow_1 = preload("res://yellow1.png")
@onready var black_5 = preload("res://black5.png")
@onready var black_3 = preload("res://black3.png")
@onready var black_1 = preload("res://black1.png")
@onready var blue_5 = preload("res://blue5.png")
@onready var blue_3 = preload("res://blue3.png")
@onready var blue_1 = preload("res://blue1.png")
@onready var green_5 = preload("res://green5.png")
@onready var green_3 = preload("res://green3.png")
@onready var green_1 = preload("res://green1.png")

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

func get_pebble_texture(color, val):
	var pair = [color, val]
	match pair:
		["purple", 5]:
			return purple_5
		["red", 5]:
			return red_5
		["green", 5]:
			return green_5
		["blue", 5]:
			return blue_5
		["black", 5]:
			return black_5
		["purple", 3]:
			return purple_3
		["red", 3]:
			return red_3
		["green", 3]:
			return green_3
		["blue", 3]:
			return blue_3
		["black", 3]:
			return black_3
		["purple", 1]:
			return purple_1
		["red", 1]:
			return red_1
		["green", 1]:
			return green_1
		["blue", 1]:
			return blue_1
		["black", 1]:
			return black_1
		["yellow", 5]:
			return yellow_5
		["yellow", 3]:
			return yellow_3
		["yellow", 1]:
			return yellow_1

func draw_pebble():
	var new_pebble = Pebble.new()
	
	var total_value = 0
	for pebble in pebbles:
		total_value += pebble.value 
	if (total_value + new_pebble.value >= 21):
		print(total_value + new_pebble.value)
		return
	var new_pebble_sprite = Sprite2D.new()
	
	new_pebble_sprite.texture = get_pebble_texture(new_pebble.color, new_pebble.value)
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
