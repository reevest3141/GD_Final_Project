extends Character


# Called when the node enters the scene tree for the first time.
func _ready():
	dead.connect(_on_death)
	pass # Replace with function body.

func _on_death():
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
