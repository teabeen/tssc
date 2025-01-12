extends Control

@onready var audioHover = $buttonSound
# Called when the node enters the scene tree for the first time.
func _ready():
	$BlackScreen.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_quit_btn_pressed():
	audioHover.play()
	get_tree().quit()


func _on_start_btn_pressed():
	audioHover.play()
	$BlackScreen.show()
	$BlackScreen/AnimationPlayer.play("fade_to_black")
	await get_tree().create_timer(2).timeout 
	get_tree().change_scene_to_file("res://scenes/plains.tscn")


func _on_controls_button_pressed():
	audioHover.play()
	pass # Replace with function body.



# handle hover sounds ⬇️
func _on_start_btn_mouse_entered():
	audioHover.play()
func _on_controls_button_mouse_entered():
	audioHover.play()
func _on_quit_btn_mouse_entered():
	audioHover.play()
