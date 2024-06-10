extends Node2D
@onready var gold_ui = get_node("/root/World/UI/Gold")
static var current_char = 0
var char_list = [preload("res://Scenes/soldier.tscn"),preload("res://Scenes/orc.tscn"),preload("res://Scenes/skeleton.tscn")]
var char_list_upgraded = [preload("res://Scenes/knight.tscn"),preload("res://Scenes/armored_orc.tscn"),preload("res://Scenes/armored_skeleton.tscn")]
var character
var gold = 0
var slimes = 4

func _enter_tree():
	character = char_list[current_char].instantiate()
	character.set_script(load("res://Scripts/player_controller.gd"))
	add_child(character)
	var new_cam = Camera2D.new()
	new_cam.zoom = Vector2(5,5)
	new_cam.name = "Camera"
	new_cam.set_script(load("res://Scripts/Camera2D.gd"))
	character.add_child(new_cam)
	

func _ready():
	gold_ui.set_text("Gold: " + str(gold))
	Dialogic.signal_event.connect(_on_dialogic_signal)
	

func update_gold(amt):
	gold += amt
	gold_ui.set_text("Gold: " + str(gold))

func SQ():
	slimes -= 1
	if slimes == 0:
		Dialogic.VAR.SQ_Complete = true

func _on_dialogic_signal(argument: String):
	if argument.left(3) == "Pay":
		update_gold(-int(argument.right(-3)))
		character.heal(character.total_hp)
	
	if argument == "SQ_Complete":
		update_gold(15)
		
	if argument == "Upgrade":
		character = char_list_upgraded[current_char]

func get_character():
	return character

func respawn():
	Dialogic.VAR.Slime_Quest = false
	Dialogic.VAR.SQ_Complete = false
	slimes = 4
	current_char += 1
	if current_char > 2:
		current_char = 0
	pass
