extends StaticBody2D

signal lap_changed

var lap = 0

var checkpoints = Array()
var nb_of_checkpoints = 3

func _on_Checkpoint_checkpoint(checkpoint_id):
	# Checkpoint logic
	if (checkpoint_id == 0):
		if (checkpoints == range(nb_of_checkpoints)):
			lap += 1
			emit_signal("lap_changed", lap)
		checkpoints = [0]
	else:
		if (checkpoints == range(checkpoint_id)):
			checkpoints = range(checkpoint_id+1)
