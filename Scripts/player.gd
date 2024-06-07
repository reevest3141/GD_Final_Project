extends Node2D
@onready var gold_ui = get_node("/root/World/UI/Gold")
@onready var character = get_child(0)
var gold = 0
var slimes = 4

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
	if argument == "Pay for inn":
		update_gold(-5)
		character.heal(character.total_hp)
	
	if argument == "SQ_Complete":
		update_gold(15)
