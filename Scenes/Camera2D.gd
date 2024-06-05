extends Camera2D

@onready var tilemap = $"../../Level1/TileMap"


func _ready():
	var mapRect = tilemap.get_used_rect()
	var tileSize = tilemap.cell_quadrant_size
	var worldSize = mapRect.size * tileSize
	limit_right = worldSize.x
	limit_bottom = worldSize.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
