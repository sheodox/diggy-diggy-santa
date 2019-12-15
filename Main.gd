extends Node
export (PackedScene) var Present

var screen_size
var score = 0
var max_presents = 30
var presents_each_level = 10

func _ready():
	start_game()
	_on_GameTimer_timeout()
	
func start_game():
	for x in range(max_presents):
		_spawn_present()

func _spawn_present():
	var present = Present.instance()
	present.connect('hit', self, "_scored")
	add_child(present)

func _scored():
	score += 1
	$HUD.update_score(score)
	_spawn_present()

var time_left = 60
func _on_GameTimer_timeout():
	time_left -= 1
	$HUD.update_time(time_left)

func _on_MaxPresentsTimer_timeout():
	for x in range(presents_each_level):
		_spawn_present()
