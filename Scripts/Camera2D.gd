extends Camera2D

func _ready():
	pass

var shake_amount = 0
var shake_timer = 0

func _process(delta):
	if shake_timer > 0:
		shake_timer -= delta
		global_position = get_parent().global_position + Vector2(randf_range(-shake_amount, shake_amount), randf_range(-shake_amount, shake_amount))

func start_shake(amount, duration):
	shake_amount = amount
	shake_timer = duration

func randf_range(min, max):
	return randf() * (max - min) + min
