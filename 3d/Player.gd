extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed = 10
export var horse : NodePath
var ridingHorse : bool
var horseobject
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !ridingHorse:
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
	if Input.is_action_just_pressed("ui_accept"):
		if ridingHorse:
			var translation = horseobject.getOffHorse()
			var root = get_tree().root
			get_parent().remove_child(self)
			root.add_child(self)
			global_translation = translation
			ridingHorse = false
			$CollisionShape.disabled = false
			pass
		var spaceState = get_world().direct_space_state
		var result : Dictionary = spaceState.intersect_ray($RayCastPoint.global_translation, Vector3(0,0,5), [self])
		print(result)
		if result.size() > 0:
			if result.collider.name == "Horse":
				$CollisionShape.disabled = true
				ridingHorse = true
				horseobject = result.collider
				var translation = horseobject.rideHorse()
				get_parent().remove_child(self)
				horseobject.add_child(self)
				global_translation = translation
	pass

