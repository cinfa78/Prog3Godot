class_name Enemy
extends CharacterBody2D

@export var health = 10
var dyingCoroutine = true

func _physics_process(delta):
	move_and_slide()

func hurt(damage):
	health-=damage
	
	$AudioStreamPlayer2D.play()
	if health <= 0:
		$Sprite2D.modulate = Color(1,0,0)
		die()
	else:		
		hurtGraphics()
func hurtGraphics():
	$CollisionShape2D.disabled = true
	$Sprite2D.modulate = Color(1,.5,0)
	await get_tree().create_timer(0.2).timeout
	$Sprite2D.modulate = Color(1,1,1)
	$CollisionShape2D.disabled = false
	
func die():	
	dyingCoroutine = true
	$CollisionShape2D.queue_free()
	while dyingCoroutine:
		#await Engine.get_main_loop().process_frame
		await RenderingServer.frame_post_draw
		if !dyingCoroutine:			
			queue_free()
			break
		


func _on_audio_stream_player_2d_finished():
	print("muori")
	dyingCoroutine = false
