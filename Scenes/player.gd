extends CharacterBody2D


@export var SPEED = 300.0
@export var sword = load("res://Scenes/sword.tscn")
#const JUMP_VELOCITY = -400.0
var canAttack = true

func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
	#	velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	# Get the input hdir and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var hdir = Input.get_axis("MoveLeft", "MoveRight")
	var vdir = Input.get_axis("MoveUp", "MoveDown")
	if hdir:
		velocity.x = hdir * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if vdir:
		velocity.y = vdir * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	if canAttack and Input.is_action_just_pressed("Attack"):
		canAttack = false
		$AttackCooldown.start() 
		var instance = sword.instantiate()
		add_child(instance)
	move_and_slide()


func _on_attack_cooldown_timeout():
	canAttack = true
