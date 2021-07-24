extends Area2D

const GROUND = Vector2(200, 136)
onready var game = get_parent()

var lifetime = 2

func _ready():
	set_position(GROUND)

func _physics_process(delta):
	if game.state == game.game_state.PLAYING:
		set_position(position + get_node("/root/game").speed * delta)
		lifetime -= delta
		if lifetime < 0:
			queue_free()

func _on_server_area_entered(area):
	if game.state == game.game_state.PLAYING:
		if area.name == "motoko":
			game.game_over()
