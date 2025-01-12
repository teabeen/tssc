extends CharacterBody2D

@export var SPEED = 100.0
const DASH_SPEED = 40000.0 # Constant dash speed
const JUMP_VELOCITY = -400.0
const DialogueBalloon = preload("res://dialogues/balloon.tscn")
var canDash = true


var dialogueStart: String = "start" # the word after ~ in dialogues indicated the position

func _ready():
	$FootstepAudio.volume_db = +5
	await get_tree().create_timer(1).timeout  # Wait so the dialogue doesn't pop up during dark screen fade
	# Intro cutscene start:
	var balloon: Node = DialogueBalloon.instantiate() # Spawn the dialogue box
	get_tree().current_scene.add_child.call_deferred(balloon)
	balloon.start(load("res://dialogues/beginningMonologue.dialogue"), dialogueStart)
	# Cutscene end
	


func _process(delta):
	
	if PlayerGlobal.isFrozen == true:
		return

	var input_dir = Input.get_vector("right", "left", "up", "down")
	if Input.is_action_just_pressed("dash") and canDash: # Use is_action_just_pressed for single action
		dash()
	velocity = input_dir * SPEED * delta
	if input_dir != Vector2.ZERO:
		$Sprite2D/AnimationPlayer.play("move_player") # The move shaking
		$CPUParticles2D.emitting = true # The moving particles from
		if not $FootstepAudio.playing:
			$FootstepAudio.pitch_scale = randf_range(0.6, 0.8)
			$FootstepAudio.play() # The stepping sound
	else:
		$FootstepAudio.stop()
		$Sprite2D.rotation = 0
		$Sprite2D/AnimationPlayer.play("idle")  # Stop the animation when not moving
		$CPUParticles2D.emitting = false # Stop the particles
	move_and_slide()


func dash():
	velocity *= 0 # Reset velocity before applying dash
	SPEED = DASH_SPEED
	$DashTimer.start()
	canDash = false
	$dashSound.play()


func _on_dash_timer_timeout():
	SPEED = 15000.0 # Reset the speed after a dash
	canDash = true
