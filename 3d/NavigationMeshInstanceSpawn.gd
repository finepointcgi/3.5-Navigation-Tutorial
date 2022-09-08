extends NavigationMeshInstance


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var SpawnableObject : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	var spawnedObject = SpawnableObject.instance()
	add_child(spawnedObject)
	bake_navigation_mesh()
	pass # Replace with function body.
