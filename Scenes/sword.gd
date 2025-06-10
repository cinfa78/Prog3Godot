extends RigidBody2D
@export var angleIncrement = 10
@export var angleAcceleration = 10
@export var damage = 5
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation_degrees = rotation_degrees + angleIncrement
	angleIncrement += angleAcceleration


func _on_self_destruct_timeout():
	queue_free()

func _on_area_2d_body_entered(body):
	print("colpito")
	if body is Enemy:
		body.hurt(damage)
