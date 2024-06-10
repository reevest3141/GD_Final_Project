extends Node2D
@onready var player = get_node("/root/World/Game Manager/Player")
var active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Dialogic.current_timeline != null:
		$TextBox.visible = false
	else:
		$TextBox.visible = active
	pass


func _on_area_2d_body_entered(body):
	if body is Player:
		active = true


func _on_area_2d_body_exited(body):
	if body is Player:
		active = false

func _input(event):
	if !active or Dialogic.current_timeline != null:
		return
		
	if event.is_action_pressed("Interact"):
		var layout = Dialogic.start("NPC_3_timeline_" + str(player.character.name))
		layout.register_character(load("res://Dialogic/npc_3.dch"), $orc)
