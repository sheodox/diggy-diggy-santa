extends Area2D
var screen_size
signal hit

export var speed = 1000

func _ready():
	screen_size = get_viewport_rect().size
	position = Vector2(screen_size.x / 2, screen_size.y / 2)

var inertia_velocity = Vector2()
func _process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
		
	# if no buttons are pressed, add some negative velocity to make santa slow down
	if velocity.length() == 0 && inertia_velocity.length() > 0:
		inertia_velocity *= 0.01
	else:
		# average between velocity and inertia to make movements not quite so jerky
		inertia_velocity += velocity
		inertia_velocity /= 2
	
	position += inertia_velocity.normalized() * delta * speed
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	