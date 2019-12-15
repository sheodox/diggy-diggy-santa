extends Area2D
signal hit

var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	position.x = rand_range(0, screen_size.x)
	position.y = rand_range(150, screen_size.y)

func _on_Present_area_entered(area):
	$CollisionShape2D.disabled = true
	$AnimatedSprite.play('found')
	emit_signal("hit")
	yield(get_tree().create_timer(0.5), 'timeout')
	queue_free()
