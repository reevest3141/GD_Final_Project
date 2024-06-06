extends CharacterBody2D

# Export variables to configure from the editor
var speed: float = 200.0
var direction: Vector2

# Reference to the AnimatedSprite node
@onready var animated_sprite: AnimatedSprite2D = $animations
var til = 0

func _ready():
	# Start the moving animation
	animated_sprite.play("Moving")

func _physics_process(delta):
	# Move the projectile in the given direction
	
	velocity = direction.normalized() * speed
	animated_sprite.play("Moving")
	
	move_and_slide()

	til += delta
	if til > 2:
		queue_free()
		



func _on_area_2d_body_entered(body):
	if(body is Player):
		var player = body as Player
		animated_sprite.play("hit")
		player.take_damage(1)
		queue_free()
		
