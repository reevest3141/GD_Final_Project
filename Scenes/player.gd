extends CharacterBody2D
@export var speed = 300
@onready var animations = $Graphics

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	animate_player()
	handle_input()
	move_and_slide()
	
func animate_player():
	#if velocity.length() == 0:
		#animations.stop()
	#else:
		#var direction = "_down"
		#if velocity.x > 0:
			#direction = "_right"
		#elif velocity.x < 0:
			#direction = "_left"
		#elif velocity.y < 0:
			#direction = "_up"
		#animations.play("walk" + direction)
	pass
	
	
func handle_input():
	var direction = Input.get_vector("Left","Right","Up","Down")
	velocity = direction * speed
	if velocity.x < 0:
		scale.x = -1
	else:
		scale.x = 1