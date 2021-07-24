extends Node2D

var speed = Vector2(-210, 0)
enum game_state {PLAYING, STOPPED, OVER}
var state = game_state.STOPPED

func _ready():
	Global.node_creation_parent = self
	#Sounds.find_node("inicio").play()

func _process(delta):
	if state == game_state.PLAYING:
		speed.x -= delta/1

func game_over():
	state = game_state.STOPPED
	$motoko.die()
	$ScoreTimer.stop()
	$hud.show_game_over()


func _on_ScoreTimer_timeout():
	Global.score += 1 
	$hud.update_score(Global.score)

func _on_StartTimer_timeout():
	$ScoreTimer.start()

func new_game():
	state = game_state.PLAYING
	Global.score = 0
	$StartTimer.start()
	$hud.update_score(Global.score)
	$hud.show_message("Get Ready")
	$hud/score.show()
	$hud/highscore.hide()
	$hud/Start.hide()
