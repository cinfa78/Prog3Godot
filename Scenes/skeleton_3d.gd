extends Skeleton3D

@export var fakeBone:Node3D
# Called when the node enters the scene tree for the first time.
func _ready():
	add_bone(fakeBone.name)
	$LookAtModifier3D.bone_name = fakeBone.name
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
