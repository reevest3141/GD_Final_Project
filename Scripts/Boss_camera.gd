extends Camera2D




# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.

var shake_amount = 0
var shake_timer = 0

func _process(delta):
	if shake_timer > 0:
		shake_timer -= delta
		global_position = get_parent().global_position + Vector2(randf_range(-shake_amount, shake_amount), randf_range(-shake_amount, shake_amount))
	#else:
		#global_position = player.global_position

func start_shake(amount, duration):
	shake_amount = amount
	shake_timer = duration

func randf_range(min, max):
	return randf() * (max - min) + min

