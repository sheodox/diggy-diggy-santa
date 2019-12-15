extends Node
export (PackedScene) var Present

var screen_size
var score = 0

func _ready():
	start_game()
	
func start_game():
	for x in range(10):
		_spawn_present()

func _spawn_present():
	var present = Present.instance()
	present.connect('hit', self, "_scored")
	add_child(present)

func _scored():
	score += 1
	$HUD.update_score(score)
	_spawn_present()

func _on_GameTimer_timeout():
		pass # Replace with function body.