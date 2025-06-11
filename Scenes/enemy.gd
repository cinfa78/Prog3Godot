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
	var timer = 0.2
	var cycle = true
	var time_now = Time.get_unix_time_from_system()
	var time_start = Time.get_unix_time_from_system()
	var time_elapsed = time_now - time_start
	while cycle:
		if !cycle:
			break
		$Sprite2D.modulate = Color(1,.5,0)
		await Engine.get_main_loop().process_frame
		$Sprite2D.modulate = Color(1,1,1)
		await Engine.get_main_loop().process_frame
		time_now = Time.get_unix_time_from_system()
		time_elapsed = time_now - time_start
		if time_elapsed>=timer:
			cycle = false
	#await get_tree().create_timer(0.2).timeout
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
