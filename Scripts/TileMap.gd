extends TileMap
signal TileMapBounds(bounds: Array[Vector2])
var camera
func _ready():
	var bounds = GetTilemapBounds()
	TileMapBounds.emit(bounds)
	pass # Replace with function body.



func GetTilemapBounds() -> Array[Vector2]:
	var bounds : Array[Vector2] = []
	bounds.append(
		Vector2(get_used_rect().position * rendering_quadrant_size)
	)
	bounds.append(
		Vector2(get_used_rect().end * rendering_quadrant_size)
	)
	return bounds

# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
