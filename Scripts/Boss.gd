extends CharacterBody2D



var player
var min_distance = 100
var max_distance = 125
var speed = 50
var rand = RandomNumberGenerator.new()
@onready var boss : AnimatedSprite2D = $AnimatedSprite2D

@export var projectile_scene : PackedScene

var isAttacking = false

var isHurt = false


func _ready():
	player = get_node("../Player")
	
	var shoot_timer = Timer.new()
	shoot_timer.wait_time = 2.0
	shoot_timer.autostart = true
	shoot_timer.connect("timeout", _on_ShootTimer_timeout)
	add_child(shoot_timer)

func _physics_process(delta):
	if(await update_velocity() > 10):
		move_and_slide()
	projectile_scene = preload("res://Scenes/Projectile.tscn")

func update_velocity():
	var target = player.get_global_position()
	var direction = global_position.direction_to(target)
	var distance = global_position.distance_to(target)
	
	if distance < min_distance:
		velocity = -direction * speed * distance/min_distance
	elif distance > min_distance:
		velocity = direction * speed * distance/min_distance
	if(distance < 125 && distance > 100):
		velocity = Vector2.ZERO
	if(isAttacking):
		boss.play("Attack_1")
		await boss.animation_finished
		isAttacking = false
	elif(isHurt):
		boss.play("Hit")
	elif(velocity == Vector2.ZERO):
		boss.play("Idle")
	else:
		boss.play("Walk")
		
	if(direction.x < 0):
		boss.flip_h = true
	if(direction.x > 0):
		boss.flip_h = false
	return global_position.distance_to(target)

func _on_ShootTimer_timeout():
	
	var directions = [Vector2(1,0), Vector2(-1,0), Vector2(0,1), Vector2(0,-1),
					  Vector2(1,1).normalized(), Vector2(-1,-1).normalized(), 
					  Vector2(1,-1).normalized(), Vector2(-1,1).normalized()]
	
	isAttacking = true
	
	for direction in directions:
		var projectile = projectile_scene.instantiate()
		projectile.global_position = global_position
		projectile.direction = direction
		projectile.z_index = 1
		projectile.rotate(atan(direction.y/direction.x))
		get_parent().add_child(projectile)
