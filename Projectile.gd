extends CharacterBody2D

# Export variables to configure from the editor
@export var speed: float = 200.0
@export var limit: float = 2.0
var direction: Vector2
var ttl = 0

# Reference to the AnimatedSprite node
@onready var animated_sprite: AnimatedSprite2D = $animations
@onready var boom: AudioStreamPlayer2D = $boom

func _ready():
	# Start the moving animation
	animated_sprite.play("Moving")

func _physics_process(delta):

	velocity = direction.normalized() * speed

	ttl += delta
	if ttl > limit:
		queue_free()

func _on_area_2d_body_entered(body):
	if body is Player:
		boom.play()
		var player = body as Player
		animated_sprite.play("hit")
		player.take_damage(1, self)
		queue_free()
	else:
		if body is TileMap:
			direction = -direction
			speed *=0.6
			scale *= 0.6
		else:
			queue_free()
