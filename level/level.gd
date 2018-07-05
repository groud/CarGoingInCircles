extends Node2D

func _ready():
	pass

func _on_AudioStreamPlayer_finished():
	$Player.running = true

func _process(delta):
	if (Input.is_action_just_pressed("ui_cancel")):
		get_tree().quit()