extends RigidBody3D

@export var forceStrength:float = 1000
@export var maxHVelocity:float = .5
@export var maxVVelocity:float = 1.5
@onready var audio_steam = $AudioSteam

@onready var left_thrust_particles = $LeftThrustParticles
@onready var right_thrust_particles = $RightThrustParticles
@onready var bottom_thrust_particles = $BottomThrustParticles

var force:Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	contact_monitor = true
	max_contacts_reported = 1;
	gravity_scale = 0.166

func _process(delta):
	force = Input.get_vector("MoveLeft","MoveRight","MoveDown","MoveUp")
	left_thrust_particles.emitting = force.x>0
	right_thrust_particles.emitting = force.x<0
	bottom_thrust_particles.emitting = force.y>0
	
	
func _physics_process(delta):	
	var appliedForce = basis.x*force.x+basis.y*force.y
	if force:
		audio_steam.play()
		apply_central_force(appliedForce *forceStrength*delta)
	else:
		audio_steam.stop()
	pass

func _on_body_entered(body):
	print("_on_body_entered "+(str)(linear_velocity.length()))
	if abs(linear_velocity.y)> maxVVelocity or abs(linear_velocity.x)>maxHVelocity:
		$AudioStreamPlayer3D.play();
	if body.is_in_group("Landing"):
		print("vittoria")
