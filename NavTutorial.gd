extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var navagent : NavigationAgent2D 

# Called when the node enters the scene tree for the first time.
func _ready():
	navagent = $NavigationAgent2D
	navagent.connect("velocity_computed", self, "_on_velocity_computed")
	pass # Replace with function body.


func _physics_process(delta):
	if navagent.is_navigation_finished():
		return
	var targetpos = navagent.get_next_location()
	var direction = global_position.direction_to(targetpos)
	print(direction)
	var velocity = direction * navagent.max_speed
	navagent.set_velocity(velocity)

func _on_velocity_computed(velocity):
	move_and_slide(velocity)
	pass


func _on_Timer_timeout():
	navagent.set_target_location(get_global_mouse_position())
	pass # Replace with function body.
