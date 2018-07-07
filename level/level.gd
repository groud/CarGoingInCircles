extends Node

func set_level_label(remaining, total):
	$"GUI/LapsLabel".text=str(remaining) + "/" + str(total)

func _ready():
	set_level_label(0, 100)

func _on_AudioStreamPlayer_finished():
	$Player.running = true

func _process(delta):
	if (Input.is_action_just_pressed("ui_cancel")):
		get_tree().quit()

func _on_Level_lap_changed(lap):
	set_level_label(lap, 100)
