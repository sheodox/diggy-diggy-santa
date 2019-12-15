extends CanvasLayer

func update_score(score):
	$Panel/Score.text = 'Score\n' + str(score)

func update_time(seconds_left):
	$Panel/TimeRemaining.text = 'Seconds Left\n' + str(seconds_left)