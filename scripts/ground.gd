extends ParallaxBackground

var parallax_offset = Vector2()
onready var motoko = get_parent().get_node("motoko")

func _process(delta):
	if motoko.is_alive == true:
		parallax_offset -= get_node("/root/game").speed * -delta
		set_scroll_offset(parallax_offset)
	else:
		parallax_offset -= get_node("/root/game").speed * -delta * 0
		set_scroll_offset(parallax_offset)
