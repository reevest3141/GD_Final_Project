extends Node2D


	
# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is TileMap:
			var new_cam = Camera2D.new()
			new_cam.set_script(load("res://Scripts/Camera2D.gd"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
