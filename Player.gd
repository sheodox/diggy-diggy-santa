extends Area2D
var screen_size
signal hit

export var speed = 1000
export var inertia_strength = 3

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
	
	if inertia_velocity.length() > 0.1:
		$AnimatedSprite.play('dig')
	else:
		$AnimatedSprite.play('default')
	
	$AnimatedSprite.flip_h = inertia_velocity.x > 0
		
	# average between velocity and inertia to make movements not quite so jerky
	inertia_velocity *= inertia_strength
	inertia_velocity += velocity
	inertia_velocity /= inertia_strength + 1
	velocity = inertia_velocity.normalized() if inertia_velocity.length() > 1 else inertia_velocity
	
	position += velocity * delta * speed
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 150, screen_size.y)
	