extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var navAgent : NavigationAgent
var velocity = Vector3()
var riding : bool
# Called when the node enters the scene tree for the first time.
func _ready():
	navAgent = $NavigationAgent
	navAgent.connect("velocity_computed", self, "_on_velocity_computed")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	if riding:
		var input_left_right := (
			Input.get_action_strength("ui_right")
			- Input.get_action_strength("ui_left")
		)
		var input_forward_back := (
			Input.get_action_strength("ui_down")
			- Input.get_action_strength("ui_up")
		)
		var raw_input = Vector2(input_left_right, input_forward_back)
		move_and_slide(Vector3(raw_input.x, 0, raw_input.y) * 20, Vector3.UP)
	else:
		if navAgent.is_navigation_finished():
			return
		var targetPos = navAgent.get_next_location()
		var direction = global_transform.origin.direction_to(targetPos)
		var distance = global_transform.origin.distance_to(get_tree().get_nodes_in_group("Player")[0].global_transform.origin)
		#print(distance)
		if distance > 10:
			navAgent.max_speed = 5
		elif distance > 4:  
			navAgent.max_speed = 3
		else:
			navAgent.max_speed = 1
	
		velocity = direction * navAgent.max_speed
		navAgent.set_velocity(velocity)
	

func _on_velocity_computed(_velocity):
	move_and_slide(_velocity, Vector3.UP)
	pass

func _on_Timer_timeout():
	navAgent.set_target_location(get_tree().get_nodes_in_group("Player")[0].global_transform.origin)
	pass # Replace with function body.

func rideHorse():
	riding = true
	return $SeatingPos.global_translation

func getOffHorse():
	riding = false
	return $StandingPos.global_translation
