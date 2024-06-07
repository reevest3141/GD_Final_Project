extends CharacterBody2D

var player
var min_distance = 100
var max_distance = 125
@export var total_hp = 10
@export var curr_hp = total_hp
var speed = 50
var rand = RandomNumberGenerator.new()
@onready var boss : AnimatedSprite2D = $AnimatedSprite2D

@export var projectile_scene : PackedScene

var isHurt = false

enum States {WALKING, IDLE, HURT, DEATH, ATTACKING}

var curr_state: States
var last_state: States

func _ready():
	player = get_node("../Player")
	
	var shoot_timer = Timer.new()
	shoot_timer.wait_time = 2.0
	shoot_timer.autostart = true
	shoot_timer.connect("timeout", _on_ShootTimer_timeout)
	add_child(shoot_timer)

	boss.connect("animation_finished", _on_animation_finished)

func _physics_process(delta):
	if update_velocity() > 10:
		move_and_slide()
	projectile_scene = preload("res://Scenes/Projectile.tscn")

func update_velocity():
	var target = player.global_position
	var direction = global_position.direction_to(target)
	var distance = global_position.distance_to(target)
	
	if distance < min_distance:
		velocity = -direction * speed * distance / min_distance
	elif distance > min_distance:
		velocity = direction * speed * distance / min_distance
	if distance < 125 and distance > 100:
		velocity = Vector2.ZERO
		
	if velocity == Vector2.ZERO and curr_state != States.ATTACKING:
		transition_to_Idle()
	elif(curr_state != States.ATTACKING):
		transition_to_Walking()
		
	match curr_state:
		States.IDLE:
			idle()
		States.WALKING:
			walk()
		States.ATTACKING:
			attack()
		States.HURT:
			hurt()
		States.DEATH:
			death()
		
	boss.flip_h = direction.x < 0

	return global_position.distance_to(target)
	
func transition_to_Walking():
	last_state = curr_state
	curr_state = States.WALKING
	
func walk():
	boss.play("Walk")

func transition_to_Idle():
	last_state = curr_state
	curr_state = States.IDLE

func idle():
	boss.play("Idle")
	
func transition_to_Attacking():
	last_state = curr_state
	curr_state = States.ATTACKING
	
func attack():
	boss.play("Attack_1")
	await boss.animation_finished
	_on_animation_finished("Attack_1")
	
func transition_to_Hurt():
	last_state = curr_state
	curr_state = States.HURT
func hurt():
	curr_hp -= 1
	boss.play("Hit")
	await boss.animation_finished
	_on_animation_finished("Hit")
	
func transition_to_Death():
	last_state = curr_state
	curr_state = States.DEATH

func death():
	boss.play("Die")
	await boss.animation_finished
	_on_animation_finished("Die")
	
func transition_to_LastState():
	curr_state = last_state
	

func _on_ShootTimer_timeout():
	transition_to_Attacking()
	
	var directions = [
		Vector2(1, 0), Vector2(-1, 0), Vector2(0, 1), Vector2(0, -1),
		Vector2(1, 1).normalized(), Vector2(-1, -1).normalized(), 
		Vector2(1, -1).normalized(), Vector2(-1, 1).normalized()
	]
	
	for direction in directions:
		var projectile = projectile_scene.instantiate()
		projectile.global_position = global_position
		projectile.direction = direction
		projectile.z_index = 1
		projectile.rotation = atan2(direction.y, direction.x)
		get_parent().add_child(projectile)

func _on_animation_finished(anim_name):
	if anim_name == "Attack_1":
		transition_to_LastState()
	if anim_name == "Hit":
		transition_to_LastState()
	if anim_name == "Die":
		boss.pause()
		



func _on_area_2d_body_entered(body):
	if(body is Player):
		var player = body as Player
		if player.isAttacking:
			transition_to_Hurt()
			
			#if(boss.health <=5 ):
				#phase2()
			if(curr_hp == 0):
				transition_to_Death()	
