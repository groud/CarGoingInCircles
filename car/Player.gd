extends KinematicBody2D

export var player = 0
export var initial_rotation = 0
export var rotation_speed = 300
export var acceleration = 600
export var max_speed = 400
export var friction = 1000

export var running = false

var rot = 0
var speed = 0

func _ready():
	rot = initial_rotation
	if (player == 1):
		$AnimatedSprite.modulate = Color(1.0, 0, 0)

slave func set_pos_and_motion(p_pos, p_rot, p_speed):
	position = p_pos
	rot = p_rot
	speed = p_speed
	
func _process(delta):
	var move = Vector2()
	var turn = 0
	if (running and is_network_master()):
		# Rotation handling
		var corrected_rotation_speed = rotation_speed * range_lerp(speed, 0, max_speed, 1.0, 0.7)
		
		if(Input.is_action_pressed("turn_right_"+str(player))):
			turn = delta * corrected_rotation_speed
		if(Input.is_action_pressed("turn_left_"+str(player))):
			turn = -delta * corrected_rotation_speed
		
		rot += turn
		while (rot < 0):
			rot += 360.0
		rot = fmod(rot, 360)
		
		# Speed handling
		if(Input.is_action_pressed("move_forward_"+str(player))):
			speed = min(max_speed, speed + delta * acceleration)
		elif(Input.is_action_pressed("move_backward_"+str(player))):
			speed = max(0, speed - delta * acceleration - delta * friction)
		else:
			speed = max(0, speed - delta * friction)
		
		# Move the car
		move = Vector2(0, -speed)
		move = move.rotated(deg2rad(rot))
		move = move_and_slide(move)
		speed = max(0, lerp(speed, move.length(), 0.1))
		
		rpc_unreliable("set_pos_and_motion", position, rot, speed)

	
	# Set animation depending on the rotation
	$AnimatedSprite.frame = int(floor((rot*8/360.0 + 3.5))) % 8
	var pitch_scale = range_lerp(move.length(), 0, max_speed, 0.24, 0.8)

	$AudioStreamPlayer.pitch_scale = pitch_scale
	
	# Particles
	
	if (delta > 0 and abs(turn / delta) > rotation_speed / 2 and speed > max_speed/1.5):
		$"TrailsPivot/Particles2D".emitting = true
		$"TrailsPivot/Particles2D2".emitting = true
	else:
		$"TrailsPivot/Particles2D".emitting = false
		$"TrailsPivot/Particles2D2".emitting = false
		
	$TrailsPivot.rotation_degrees = rot
	$"TrailsPivot/Particles2D".process_material.angle = rot + 90
	$"TrailsPivot/Particles2D2".process_material.angle = rot + 90