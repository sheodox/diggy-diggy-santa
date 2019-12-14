extends Area2D
signal hit

var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	position.x = rand_range(0, screen_size.x)
	position.y = rand_range(0, screen_size.y)

func _on_Present_area_entered(area):
	emit_signal("hit")
	queue_free()
