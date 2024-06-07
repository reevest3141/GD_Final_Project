extends Camera2D

@export var tilemap : TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	var mapRect = tilemap.get_used_rect()
	var tileSize = tilemap.cell_quadrant_size
	var worldSize = mapRect.size * tileSize
	limit_left = -worldSize.x/1.5
	limit_right = worldSize.x/1.5
	limit_bottom = worldSize.y/1.75
	limit_top = -worldSize.y/2
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
