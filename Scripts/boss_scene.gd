extends Node2D
# Called when the node enters the scene tree for the first time.
@onready var door : Area2D = $Door
func _ready():
	door.get_child(0).play("closed")
	for obj in get_children():
		if(obj is Candle):
			var light_source = obj as Candle
			light_source.play_sprite("flicker")
		elif (obj is Torch):
			var light_source = obj as Torch
			light_source.play_sprite("flicker")
	pass # Replace with function body.

@onready var boss : CharacterBody2D = $Boss
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(boss.dead):
		door.get_child(0).play("opened")
		door.opened = true
