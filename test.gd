extends Sprite2D


var waitingOnInput = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (!waitingOnInput):
		print("Draw a stone")
		waitingOnInput = true
		
func _input(event):
	if event.as_text() == "D":
		print("Drew stone")
		waitingOnInput = false
	
	
