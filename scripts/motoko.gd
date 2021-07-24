extends Area2D

const ENEMIES = [preload("res://prefabs/cloud.tscn"),
				 preload("res://prefabs/server.tscn"),
				 preload("res://prefabs/server2.tscn")]

const GROUND = Vector2(21, 144)
const GRAVITY = 2000
const JUMP = -600
var is_alive = true
var velocity = Vector2()
var interval = 3
var loop_time = 0.0
onready var game = get_parent()
var body = preload("res://scenes/Body.tscn")

func _ready():
	set_position(GROUND)
	randomize()

func _process(delta):
	if game.state == game.game_state.PLAYING:
		if is_alive:
			if velocity.y < 0:
				$anim.play("jump")
			elif velocity.y > 0 and position != GROUND:
				$anim.play("fall")
			else:
				$anim.play("run")

			velocity.y += GRAVITY * delta 
			position += velocity * delta

		#if game.state == game.game_state.PLAYING:
			loop_time += delta
	
			if loop_time >= interval:
				loop_time = 0.0
				var random_carrots_idx = rand_range(0, ENEMIES.size())
				get_parent().add_child(ENEMIES[random_carrots_idx].instance())
				interval = rand_range(1, 2)
	
		if get_position().y > GROUND.y:
			set_position(GROUND)

func jump():
		velocity.y = JUMP 
		Sounds.find_node("jump").play()

func _input(event):
	if game.state == game.game_state.PLAYING:
		if event.is_action_pressed("ui_jump") and position == GROUND:
			jump()
			if is_alive:
				yield(get_tree().create_timer(0.5), "timeout")
			else:
				return
		if event is InputEventScreenTouch and position == GROUND:
			jump()
			if is_alive:
				yield(get_tree().create_timer(0.5), "timeout")
			else:
				return

func die():
	if is_alive:
		is_alive = false
		for child in self.get_children():
			child.queue_free()
		Global.instance_node(body, position, Global.node_creation_parent)
		Sounds.find_node("hit").play()


func _on_Start_pressed():
	jump()
