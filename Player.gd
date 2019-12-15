extends Area2D
var screen_size
signal hit

func _ready():
	screen_size = get_viewport_rect().size
	position = Vector2(screen_size.x / 2, screen_size.y / 2)

func _process(delta):
	var pos = get_viewport().get_mouse_position()
	var diff = position - pos
	$AnimatedSprite.flip_h = diff.x < 0
	$AnimatedSprite.play('dig' if diff.length() > 0 else 'default')
	position.x = clamp(pos.x, 0, screen_size.x)
	position.y = clamp(pos.y, 150, screen_size.y)