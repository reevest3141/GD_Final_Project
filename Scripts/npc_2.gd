extends Node2D
var active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Dialogic.current_timeline != null:
		$TextBox.visible = false
		$Exclamation.visible = false
	else:
		$TextBox.visible = active
		$Exclamation.visible = (!active && !Dialogic.VAR.Slime_Quest)



func _on_interaction_area_body_entered(body):
	if body is Player:
		active = true
	pass # Replace with function body.


func _on_interaction_area_body_exited(body):
	if body is Player:
		active = false
	pass # Replace with function body.

func _input(event):
	if !active or Dialogic.current_timeline != null:
		return
		
	if event.is_action_pressed("Interact"):
		var layout = Dialogic.start("NPC_2_timeline")
		layout.register_character(load("res://Dialogic/npc_2.dch"), $Priest)
