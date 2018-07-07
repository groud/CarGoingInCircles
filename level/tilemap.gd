extends StaticBody2D

signal level_done

export var number_of_laps = 3

var laps = number_of_laps + 1

func _on_Checkpoint_checkpoint(checkpoint_id):
	# We should do better tests !
	laps -= 1
	
	if (laps <= 0):
		print("Level done !")
	else:
		print(str(laps) + " laps remaining..." )
