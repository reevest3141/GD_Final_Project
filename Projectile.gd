extends CharacterBody2D

# Export variables to configure from the editor
var speed: float = 200.0
var direction: Vector2

# Reference to the AnimatedSprite node
@onready var animated_sprite: AnimatedSprite2D = $animations
@onready var boom : AudioStreamPlayer2D = $boom
var ttl = 0
@export var limit = 2

func _ready():
	# Start the moving animation
	animated_sprite.play("Moving")

func _physics_process(delta):
	# Move the projectile in the given direction
	
	velocity = direction.normalized() * speed
	animated_sprite.play("Moving")
	
	move_and_slide()

	ttl += delta
	if ttl > limit:
		queue_free()
		



func _on_area_2d_body_entered(body):
	if(body is Player):
		boom.play()
		var player = body as Player
		animated_sprite.play("hit")
		player.take_damage(1, self)
		queue_free()
		
