extends Camera2D

func _process(delta):
	position = ($"../Player0".position + $"../Player1".position) / 2
	var screen_size = get_viewport().get_visible_rect().size
	var lower_limit = min(screen_size.x, screen_size.y)
	var dist = $"../Player0".position.distance_to($"../Player1".position)
	var zoom_level = range_lerp(dist, lower_limit-200, 2*lower_limit, 1.2, 2)
	zoom_level = max(1, zoom_level)
	zoom.y = zoom_level
	zoom.x = zoom_level
	
