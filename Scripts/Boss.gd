extends CharacterBody2D
class_name Enemy

var player
var min_distance = 100
var max_distance = 125
@export var total_hp = 16
@export var current_hp = total_hp
var speed = 50
var rand = RandomNumberGenerator.new()
@onready var boss: AnimatedSprite2D = $Graphics
@onready var health_bar: AnimatedSprite2D = $HealthBar

@export var projectile_scene: PackedScene

var i = 1

enum States {WALKING, IDLE, HURT, DEATH, ATTACKING, ATTACKING2}
enum Phases {PHASEONE, PHASETWO}

var inAttackRange = false
var phase2flag = true
var boss_phase: Phases

var curr_state: States
var last_state: States
var phase2Timer = 0

var camera

var isHurt = false
var dead = false

var shoot_timer

func _ready():
	player = get_node("/root/World/Game Manager/Player").get_child(0)
		
	camera = player.get_node("Camera2D")
	shoot_timer = Timer.new()
	shoot_timer.wait_time = 2.0
	shoot_timer.autostart = true
	shoot_timer.connect("timeout", _on_ShootTimer_timeout)
	add_child(shoot_timer)
	health_bar.play("Damage_0")
	boss_phase = Phases.PHASEONE
	projectile_scene = preload("res://Scenes/Projectile.tscn")
	boss.connect("animation_finished", _on_animation_finished)

func _physics_process(delta):
	if update_velocity() > 10 && !dead:
		move_and_slide()

var justAttacked = false
var projectileAttack2 = false

func update_velocity():
	var target = player.global_position
	var direction = global_position.direction_to(target)
	var distance = global_position.distance_to(target)
	
	if(dead):
		curr_state = States.DEATH
	match curr_state:
		States.IDLE:
			idle()
		States.WALKING:
			walk()
		States.ATTACKING:
			attack()
		States.HURT:
			take_damage()
		States.DEATH:
			death()
			
	match boss_phase:
		Phases.PHASEONE:
			if distance < min_distance:
				velocity = -direction * speed * distance / min_distance
			elif distance > min_distance:
				velocity = direction * speed * distance / min_distance
			if distance < 125 and distance > 100:
				velocity = Vector2.ZERO
		Phases.PHASETWO:
			if(shoot_timer.is_connected("timeout",  _on_ShootTimer_timeout)):
				shoot_timer.disconnect("timeout",  _on_ShootTimer_timeout)
			if( distance < 10):
				velocity = -direction * speed * (distance+25)/100
			elif(distance > 10):
				velocity = direction * speed * (distance+25)/100
			if(distance < 20 and distance > 10):
				velocity = Vector2.ZERO
				inAttackRange = true
			if(inAttackRange && !justAttacked):
				transition_to_Attacking()
				justAttacked = true
			elif(justAttacked):
				if distance < 175:
					velocity = -direction * speed * 75/distance
				elif distance > 175:
					velocity = direction * speed * 75/distance
				if distance < 200 and distance > 175:
					velocity = Vector2.ZERO
					transition_to_Attacking()
					phase2Projectiles()
					justAttacked = false
					inAttackRange = false
	
	if velocity == Vector2.ZERO and curr_state != States.ATTACKING:
		transition_to_Idle()
	elif curr_state != States.ATTACKING:
		transition_to_Walking()
		
	if(!dead):
		boss.flip_h = direction.x < 0
		if(direction.x < 0):
			health_bar.global_position.x = global_position.x + 15 
		else:
			health_bar.global_position.x = global_position.x

	if(isHurt):
		isHurt = false
	
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
	
func attack(dmg = 1):
	boss.play("Attack_1")
	await boss.animation_finished
	_on_animation_finished("Attack_1")
		
	
func transition_to_Hurt():
	last_state = curr_state
	curr_state = States.HURT
	
func take_damage(dmg = 1):
	if(isHurt):
		return
	isHurt = true
	current_hp -= dmg
	if current_hp <= 0:
		transition_to_Death()
		return
	boss.play("Hit")
	await boss.animation_finished
	_on_animation_finished("Hit")
	if current_hp % 4 == 0:
		health_bar.play("Damage_" + str(i))
		i += 1
	

	
	if current_hp <= 8 and phase2flag:
		shake_camera()
		boss_phase = Phases.PHASETWO
		phase2flag = false

func transition_to_Death():
	last_state = States.DEATH
	curr_state = States.DEATH

func death():
	health_bar.play("Damage_4")
	
	boss.play("Die")
	await boss.animation_finished
	dead = true
	_on_animation_finished("Die")
	
func transition_to_LastState():
	curr_state = last_state


@onready var collision_right = $Area2D/HurtBox
@onready var collision_left = $Area2D2/HurtBox2

func phase2Projectiles():
	for num in range(10):
		var projectile = projectile_scene.instantiate()
		
		var vertex
		
		if(boss.flip_h):
			vertex = boss.to_global(collision_left.get_polygon()[2+num])
		else:
			vertex = boss.to_global(collision_right.get_polygon()[2+num])

		var direction =  global_position.direction_to(player.get_global_position())
		projectile.global_position = vertex
		projectile.direction = direction
		projectile.z_index = 1
		projectile.rotation = atan2(direction.y, direction.x)
		projectile.speed = 150
		projectile.limit = 4
		get_parent().add_child(projectile)
	

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
	if anim_name == "Attack_1" or anim_name == "Hit":
		transition_to_LastState()
	elif anim_name == "Die":
		boss.stop()
	
func shake_camera():
	camera.start_shake(5, 1) 
	

func _on_Right_body_entered(body):
	if(body is Player):
		if(curr_state == States.ATTACKING && !boss.flip_h):
			var player = body as Player
			player.take_damage(1)

func _on_Left_body_entered(body):
	if(body is Player):
		if(curr_state == States.ATTACKING && boss.flip_h):
			var player = body as Player
			player.take_damage(1)
