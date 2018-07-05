extends KinematicBody2D

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

func _process(delta):
	var move = Vector2()
	if (running):
		# Rotation handling
		var corrected_rotation_speed = rotation_speed * range_lerp(speed, 0, max_speed, 1.0, 0.7)
		
		if(Input.is_action_pressed("ui_right")):
			rot += delta * corrected_rotation_speed
		if(Input.is_action_pressed("ui_left")):
			rot -= delta * corrected_rotation_speed
		
		while (rot < 0):
			rot += 360.0
		rot = fmod(rot, 360)
		
		# Speed handling
		if(Input.is_action_pressed("ui_up")):
			speed = min(max_speed, speed + delta * acceleration)
		elif(Input.is_action_pressed("ui_down")):
			speed = max(0, speed - delta * acceleration - delta * friction)
		else:
			speed = max(0, speed - delta * friction)
		
		# Move the car
		move = Vector2(0, -speed)
		move = move.rotated(deg2rad(rot))
		move = move_and_slide(move)
		speed = max(0, lerp(speed, move.length(), 0.1))
	
	# Set animation depending on the rotation
	$AnimatedSprite.frame = int(floor((rot*8/360.0 + 3.5))) % 8
	var pitch_scale = range_lerp(move.length(), 0, max_speed, 0.24, 0.8)
	AudioServer.get_bus_effect(AudioServer.get_bus_index("Car"), 0).pitch_scale = pitch_scale
	