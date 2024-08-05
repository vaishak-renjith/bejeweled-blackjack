extends Node2D

const card_texture = preload("res://icon.svg")

# Constants for card spacing
var CARD_WIDTH = card_texture.get_width()
const CARD_SPACING = 10
const FLOAT_DISTANCE = 5
const FLOAT_TIME = 0.5

var can_draw = true

# Example card textures
var cards = []  # Array of textures for the cards

# Function to update the card positions
func update_card_positions():
	var num_cards = cards.size()
	var total_width = num_cards * CARD_WIDTH + (num_cards - 1) * CARD_SPACING
	var start_x = get_viewport().get_visible_rect().size.x/2 + (CARD_WIDTH/2) - total_width/2
	for i in range(num_cards):
		cards[i].position = Vector2(start_x + i * (CARD_WIDTH + CARD_SPACING), get_viewport().get_visible_rect().size.y/2) 

# Function to draw a new card
func draw_card(texture: Texture):
	var card = Sprite2D.new()
	card.texture = texture
	card.texture = texture
	cards.append(card)
	add_child(card)
	update_card_positions()
	
	
	# to fix tweening issues use interpolate property
	var tween = create_tween()
	tween.set_loops(-1)
	tween.tween_property(card, 'position', Vector2.RIGHT * FLOAT_DISTANCE, 1).as_relative().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(card, 'position', Vector2.LEFT * FLOAT_DISTANCE, 1).as_relative().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	var vertical_tween = create_tween()
	vertical_tween.set_loops(-1) 
	vertical_tween.tween_property(card, 'position', Vector2(0, -10), FLOAT_TIME).as_relative().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	vertical_tween.tween_property(card, 'position', Vector2(0, 10), FLOAT_TIME).as_relative().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

# Function to remove a card (optional)
func remove_card(index: int):
	if index >= 0 and index < cards.size():
		cards.remove_at(index)
		update_card_positions()

func _input(event):
	if event.as_text() == "D" and can_draw:
		draw_card(card_texture)
		can_draw = false
		$Timer.start()
		
func _on_timer_timeout():
	can_draw = true
