extends RigidBody3D

@export var forceStrength:float = 2000
var force:Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	contact_monitor = true
	max_contacts_reported = 5
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	force = Input.get_vector("MoveLeft","MoveRight","MoveDown","MoveUp")
	pass
	
func _physics_process(delta):	
	var appliedForce = Vector3(force.x, force.y, 0)
	if force:
		apply_central_force(appliedForce *forceStrength*delta)
	pass

func _on_body_entered(body):
	print("_on_body_entered "+(str)(linear_velocity.length()))
	
	$AudioStreamPlayer3D.play();
	pass # Replace with function body.
