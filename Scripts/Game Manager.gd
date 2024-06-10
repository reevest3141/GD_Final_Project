extends Node2D
@onready var player = get_node("Player")
var levels = [preload("res://Scenes/forest.tscn"),preload("res://Scenes/town.tscn"),preload("res://Scenes/boss_scene.tscn")]
var player_spawn = [Vector2(145,90),Vector2(-10,2),Vector2(250,500)]
var nl_spawn = [Vector2(1000,130),Vector2(1400,50),Vector2(-100,200)]
var cur = 0

func _ready():
	$new_level.body_entered.connect(change_scene)
	pass # Replace with function body.
func change_scene(body):
	print("theo")
	$Level.get_child(0).queue_free()
	cur += 1
	if(cur == 2):
		$Audio.stop()
	call_deferred("setup_scene")
	
func setup_scene():
	$Level.add_child(levels[cur].instantiate())
	player.character.global_position = player_spawn[cur]
	$new_level.global_position = nl_spawn[cur]

func _process(delta):
	pass
