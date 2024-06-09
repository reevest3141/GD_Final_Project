extends Node2D

@onready var candle_1 : AnimatedSprite2D = $candle_1
@onready var candle_2 : AnimatedSprite2D = $candle_2
@onready var candle_3 : AnimatedSprite2D = $candle_3
@onready var candle_4 : AnimatedSprite2D = $candle_4
@onready var candle_5 : AnimatedSprite2D = $candle_5

@onready var torch_1 : AnimatedSprite2D = $torch_1
@onready var torch_2 : AnimatedSprite2D = $torch_2


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	candle_1.play("flicker")
	candle_2.play("flicker")
	candle_3.play("flicker")
	candle_4.play("flicker")
	candle_5.play("flicker")
	torch_1.play("flicker")
	torch_2.play("flicker")
