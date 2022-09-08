extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	var input_left_right := (
		Input.get_action_strength("ui_right")
		- Input.get_action_strength("ui_left")
	)
	var input_forward_back := (
		Input.get_action_strength("ui_down")
		- Input.get_action_strength("ui_up")
	)
	var raw_input = Vector2(input_left_right, input_forward_back)
	move_and_slide(Vector3(raw_input.x, 0, raw_input.y) * speed, Vector3.UP)
	
	pass

