extends CanvasLayer
signal start_game
signal _video_finished
# used by Main to pause background music
signal video_playing

# only show the video the first time
var video_viewed = false

func _ready():
	show_main_menu()

func show_main_menu():
	$GamePanel.hide()
	$MainMenu.show()
	$GameOver.hide()

func start_game():
	$MainMenu.hide()
	if !video_viewed:
		_show_video()
		yield(self, '_video_finished')
	$GamePanel.show()
	emit_signal('start_game')

func _show_video():
	emit_signal('video_playing', true)
	$VideoPlayer.show()
	$VideoPlayer.play()
	yield($VideoPlayer, 'finished')
	$VideoPlayer.hide()
	video_viewed = true
	emit_signal('_video_finished')
	emit_signal('video_playing', false)

func update_score(score):
	$GamePanel/Score.text = 'Score\n' + str(score)

func update_time(seconds_left):
	$GamePanel/TimeRemaining.text = 'Seconds Left\n' + str(seconds_left)

func _on_StartGameButton_pressed():
	start_game()

func short_reveal_timer():
	return get_tree().create_timer(2)

var children_in_world = 2_200_000_000
func game_over(score):
	$GameOver.show()
	$GameOver/RuinedChristmases.hide()
	$GameOver/Ok.hide()
	
	$GameOver/FinalScore.text = 'Thanks! I can give these presents to ' + str(score) + '\nlittle girls and boys in the world. For them Christmas is saved!'
	yield(short_reveal_timer(), 'timeout')
	$GameOver/RuinedChristmases.show()
	$GameOver/RuinedChristmases.text = 'That means Christmas is ruined for\nonly ' + str(children_in_world - score) + ' children. Good job!'
	yield(short_reveal_timer(), 'timeout')
	$GameOver/Ok.show()
	
	

func _on_GameOverOk_pressed():
	show_main_menu()


func _on_About_pressed():
	OS.shell_open('https://github.com/sheodox/diggy-diggy-santa')
