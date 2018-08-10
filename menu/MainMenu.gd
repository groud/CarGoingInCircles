extends Node

func _ready():
	$"VBoxContainer/PlayButton".grab_focus()

func _on_PlayButton_pressed():
	get_tree().change_scene("res://level/level.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_MultiplayerButton_pressed():
	$VBoxContainer.hide()
	$lobby.show()
	get_tree().change_scene("res://lobby.tscn")
