extends Node
export (PackedScene) var Present
signal game_over

var screen_size
var score = 0
var max_presents = 60
var current_max_presents
var presents_each_level = 20
var game_max_time = 60
var time_left

func start_game():
	score = 0
	# add one because we decrement immediately to update the time in the HUD
	time_left = game_max_time + 1
	current_max_presents = max_presents
	for x in range(current_max_presents):
		_spawn_present()
	# show time in the hud
	_on_GameTimer_timeout()
	$GameTimer.start()
	$MaxPresentsTimer.start()
	$Player.can_move = true

func _spawn_present():
	var present = Present.instance()
	present.connect('hit', self, "_scored")
	$HUD.connect('start_game', present, 'remove')
	add_child(present)

func _scored():
	score += 1
	$HUD.update_score(score)
	_spawn_present()

func _on_GameTimer_timeout():
	time_left -= 1
	$HUD.update_time(time_left)
	if time_left == 0:
		_game_over()

func _game_over():
	$Player.can_move = false
	$HUD.game_over(score)
	$GameTimer.stop()
	$MaxPresentsTimer.stop()

func _on_MaxPresentsTimer_timeout():
	for x in range(presents_each_level):
		_spawn_present()


var is_paused_because_video = false
func _on_HUD_video_playing(is_playing):
	is_paused_because_video = is_playing
	if is_playing:
		$Music.stop()
	else:
		$Music.play()


func _on_Music_finished():
	# loop, just don't cause it to restart when the FMV is playing
	if !is_paused_because_video:
		$Music.play()
