extends ParallaxBackground

var parallax_offset = 0
onready var motoko = get_parent().get_node("motoko")

func _process(delta):
	if motoko.is_alive == false:
		parallax_offset -= delta * 0
		set_scroll_offset(Vector2(parallax_offset, 0))
	else:
		parallax_offset -= delta * 20
		set_scroll_offset(Vector2(parallax_offset, 0))
