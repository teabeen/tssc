extends CharacterBody2D

const DialogueBalloon = preload("res://dialogues/balloon.tscn")

var startedDialogue = false
var startDialogue = false
var dialogueStart = "start"
var player_node: Node2D  # Reference to the player
var speed = 500  # NPC movement speed

# Called when the node enters the scene tree for the first time.
func _ready():
	player_node = get_node("../Player")  # Ensure the Player node exists
	hide()  # Start hidden

func _process(delta):
	if startDialogue and not startedDialogue:  # Only run if triggered and dialogue hasn't started
		move_toward_player(delta)

func move_toward_player(_delta):
	# Calculate direction toward the player
	var playerTarget = (player_node.global_position - global_position).normalized()
	velocity = playerTarget * speed  # Frame-independent velocity
	show()  # Ensure the NPC is visible
	$AnimationPlayer.play("move_player")
	move_and_slide()

	# Check if NPC is close enough to start dialogue
	if global_position.distance_to(player_node.global_position) < 30:
		$AnimationPlayer.stop()
		start_dialogue()

func start_dialogue():
	rotation = 0
	velocity = Vector2.ZERO  # Stop movement
	var balloon: Node = DialogueBalloon.instantiate()  # Spawn the dialogue box
	get_tree().current_scene.add_child.call_deferred(balloon)
	balloon.start(load("res://dialogues/georgeQuest.dialogue"), dialogueStart)
	startedDialogue = true  # Mark dialogue as started

# Triggered when the player enters the town
func _on_player_enter_town_body_entered(body):
	if body.name == "Player":  # Ensure it's the player triggering the signal
		startDialogue = true
