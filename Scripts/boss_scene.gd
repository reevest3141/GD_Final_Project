extends Node2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for obj in get_children():
		if(obj is Candle):
			var light_source = obj as Candle
			light_source.play_sprite("flicker")
		elif (obj is Torch):
			var light_source = obj as Torch
			light_source.play_sprite("flicker")
