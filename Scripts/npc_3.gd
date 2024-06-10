extends Node2D
@onready var character = get_child(0)


# Called when the node enters the scene tree for the first time.
func _ready():
	character.hit.connect(_on_hit)
	pass # Replace with function body.

func _on_hit(origin):
	#character.set_script(preload("res://Scripts/aggro_npc.gd"))
	#character.target = origin
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
