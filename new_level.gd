extends Area2D

var newScene = preload("res://Scenes/town.tscn")

func _on_body_entered(body):
	if body is Player:
		get_tree().call_deferred("change_scene_to_packed", newScene)
