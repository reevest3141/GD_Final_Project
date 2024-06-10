extends Area2D
class_name Door

var opened = false
# Called when the node enters the scene tree for the first time.
func _ready():
	opened = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
@export var target_scene : PackedScene = preload("res://Scenes/forest.tscn")

func _on_body_entered(body):
	if(body is Player and opened):
		var player = body as Player
		player.respawn()
		get_tree().call_deferred("change_scene_to_packed", target_scene)
		
