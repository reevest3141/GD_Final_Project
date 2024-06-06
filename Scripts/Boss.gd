extends CharacterBody2D



var player
var min_distance = 200
var max_distance = 300
var speed = 100
var rand = RandomNumberGenerator.new()
@onready var boss : AnimatedSprite2D = $AnimatedSprite2D


func _ready():
	player = get_node("../Player")
	
	var shoot_timer = Timer.new()
	shoot_timer.wait_time = 2.0
	shoot_timer.autostart = true
	shoot_timer.connect("timeout", _on_ShootTimer_timeout)
	add_child(shoot_timer)

func _physics_process(delta):
	var direction = (player.global_position - global_position).normalized()
	var distance = global_position.distance_to(player.global_position)
	var move = 0
	if(delta - int(delta) < 1.0 && delta - int(delta) < 0.0):
		move = rand.randf_range(0.1, 1)
	if distance < min_distance:
		velocity = -direction * speed * move
		boss.play("Walk")
	elif distance > max_distance:
		velocity = direction * speed * move
		boss.play("Walk")
	if(velocity.length() == 0):
		boss.play("Idle")
		
	if(direction.x < 0):
		boss.flip_h = true
	if(direction.x > 0):
		boss.flip_h = false
		
	move_and_slide()
#var projectile_scene = preload("res://Scenes/Projectile.tscn")
	

func _on_ShootTimer_timeout():
	var directions = [Vector2(1,0), Vector2(-1,0), Vector2(0,1), Vector2(0,-1),
					  Vector2(1,1).normalized(), Vector2(-1,-1).normalized(), 
					  Vector2(1,-1).normalized(), Vector2(-1,1).normalized()]

	#for direction in directions:
		#var projectile = projectile_scene.instance()
		#projectile.position = global_position
		#projectile.direction = direction
		#get_parent().add_child(projectile)
