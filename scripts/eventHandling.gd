extends Node

func _on_town_hall_entrance_body_entered(body):
	if body.has_meta("player"):
		# Use call_deferred to safely change the scene
		call_deferred("change_scene")

func change_scene():
	get_tree().change_scene_to_file("res://scenes/town_hall.tscn")
