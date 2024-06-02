extends CharacterBody2D
@onready var Player = get_node("/root/World/Game Manager/Player")
@export var speed = 100
@export var damage = 2
@export var total_hp = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	if (update_velocity() > 10):
		move_and_slide()


func update_velocity():
	var target = Player.get_global_position()
	velocity = position.direction_to(target) * speed
	return position.distance_to(target)
