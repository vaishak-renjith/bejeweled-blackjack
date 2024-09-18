extends Node2D

const red_card_texture = preload("res://red.png")
const blue_card_texture = preload("res://blue.png")
const green_card_texture = preload("res://green.png")
const black_card_texture = preload("res://black.png")
const yellow_card_texture = preload("res://yellow.png")
const purple_card_texture =  preload("res://purple.png")

var random_textures = [red_card_texture, blue_card_texture, green_card_texture, black_card_texture, yellow_card_texture, purple_card_texture]

var SCALE_FACTOR = 8
var CARD_WIDTH = red_card_texture.get_width()
const CARD_SPACING = 100
const FLOAT_DISTANCE = 5
const FLOAT_TIME = 1

var can_draw = true

var cards = []
var pebble_hand = get_tree()

# Function to update the card positions
func update_card_positions():
	var num_cards = cards.size()
	var total_width = num_cards * CARD_WIDTH + (num_cards - 1) * CARD_SPACING
	var start_x = get_viewport().get_visible_rect().size.x/2 + (CARD_WIDTH/2) - total_width/2
	for i in range(num_cards):
		cards[i].position = Vector2(start_x + i * (CARD_WIDTH + CARD_SPACING), 2.5*get_viewport().get_visible_rect().size.y/4) 
		
func getInitPos(i):
	var num_cards = cards.size()
	var total_width = num_cards * CARD_WIDTH + (num_cards - 1) * CARD_SPACING
	var start_x = get_viewport().get_visible_rect().size.x/2 + (CARD_WIDTH/2) - total_width/2
	return Vector2(start_x + i * (CARD_WIDTH + CARD_SPACING), 2.5*get_viewport().get_visible_rect().size.y/4) 

func _draw():
	print("draw called")

func draw_card(texture: Texture):
	var card = Sprite2D.new()
	card.texture = texture
	cards.append(card)
	card.scale = Vector2(8, 8)
	add_child(card)
	update_card_positions()

func use_card(index):
	if (!is_selected(index)):
		return
	var selected_card = cards[index]
	if (selected_card.texture.resource_path.get_file() == "blue.png"):
		if (pebble_hand.has_pebble("blue", 1)):
			print("blue spell used")

func is_selected(i: int) -> bool:
	var card = cards[i]
	var card_size = card.texture.get_size() * SCALE_FACTOR
	var init_pos = getInitPos(i)
	
	var rect = Rect2(init_pos - Vector2(CARD_WIDTH*SCALE_FACTOR/2.8, -card_size.y/3.75), card_size * Vector2(0.75, 1))

	var mouse_position = get_viewport().get_mouse_position()
	#print(mouse_position, ", ", getInitPos(i))

	return rect.has_point(mouse_position)


# Variables to track time
var time_passed = 0.0

func _process(delta):
	time_passed += delta

	var horizontal_offset = sin(time_passed * TAU / 1.1) * 2

	var vertical_offset = sin(time_passed * TAU / FLOAT_TIME) * FLOAT_DISTANCE - 20

	for i in range(cards.size()):
		if is_selected(i):
			var horizontal_position = getInitPos(i).x + horizontal_offset
			var vertical_position = getInitPos(i).y + vertical_offset
			cards[i].position = Vector2(horizontal_position, vertical_position)
			if (Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
				use_card(i)
		else:
			cards[i].position = getInitPos(i)
	#queue_redraw()

func remove_card(index: int):
	if index >= 0 and index < cards.size():
		cards.remove_at(index)
		update_card_positions()

func _input(event):
	if event.as_text() == "D" and can_draw:
		draw_card(random_textures.pick_random())
		can_draw = false
		$Timer.start()

func _ready():
	pebble_hand = get_node("/root/Main/PebbleHand")

func _on_timer_timeout():
	can_draw = true
