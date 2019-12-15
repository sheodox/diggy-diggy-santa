extends Area2D
var screen_size
signal hit

var can_move = false

func _process(delta):
	if !can_move:
		return
	# make sure we know the proper screen size, could have changed if the window was resized and 
	screen_size = get_viewport_rect().size
	var pos = get_viewport().get_mouse_position()
	var diff = position - pos
	$AnimatedSprite.flip_h = diff.x < 0
	$AnimatedSprite.play('dig' if diff.length() > 0 else 'default')
	position.x = clamp(pos.x, 0, screen_size.x)
	position.y = clamp(pos.y, 150, screen_size.y)