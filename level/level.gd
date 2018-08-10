extends Node

export var multi = true

func set_level_label(remaining, total):
	$"GUI/LapsLabel".text=str(remaining) + "/" + str(total)

func _ready():
	set_level_label(0, 100)
	if (multi):
		if (get_tree().is_network_server()):
			$Player1.set_network_master(get_tree().get_network_connected_peers()[0])
		else:
			$Player1.set_network_master(get_tree().get_network_unique_id())

func _on_AudioStreamPlayer_finished():
	$Player0.running = true
	$Player1.running = true

func _process(delta):
	if (Input.is_action_just_pressed("ui_cancel")):
		get_tree().quit()

func _on_Level_lap_changed(lap):
	set_level_label(lap, 100)
