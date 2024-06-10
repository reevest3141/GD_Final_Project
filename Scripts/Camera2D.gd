extends Camera2D
@onready var tilemap = get_node("/root/World/Game Manager/Level").get_child(0).get_child(0)
func _ready():
	pass
	#tilemap.TileMapBounds.connect(UpdateLimits)
#
#func UpdateLimits(bounds: Array[Vector2]) -> void:
	#if bounds == []:
		#return
	#limit_left = int(bounds[0].x)
	#limit_right = int(bounds[1].x)
	#limit_bottom = int(bounds[1].y)
	#limit_top = int(bounds[0].y)
	#pass  
