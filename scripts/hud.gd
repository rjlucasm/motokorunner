extends CanvasLayer

signal start_game
var change
onready var game = get_parent()
onready var motoko = get_parent().get_node("motoko")

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func update_score(score):
	$score.text = str(score)

func show_game_over():
	yield(get_tree().create_timer(2), "timeout")
	$Restart.show()
	if Global.score > Global.bestscore:
		Global.bestscore = Global.score

	if Global.score == Global.bestscore:
		$new_highscore.show()
	
	game.state = game.game_state.OVER
	
func _on_MessageTimer_timeout():
	$MessageLabel.hide()

func _ready():
	$highscore.text = str("Best ", Global.bestscore)

func _input(event):
	if game.state == game.game_state.STOPPED and motoko.is_alive:
		if event.is_action_pressed("ui_jump"): #or event is InputEventScreenTouch:
			emit_signal("start_game")
	if game.state == game.game_state.OVER:
		if event.is_action_pressed("ui_jump"):
			change = get_tree().reload_current_scene()
		if event is InputEventScreenTouch:
			change = get_tree().reload_current_scene()


func _on_Start_pressed():
	#$Start.hide()
	emit_signal("start_game")
