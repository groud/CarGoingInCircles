extends Area2D

export var checkpoint_id = 0

signal checkpoint

func _ready():
	pass

func _on_Checkpoint_body_entered(body):
	emit_signal("checkpoint", checkpoint_id)
