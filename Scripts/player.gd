extends CharacterBody2D
@export var speed = 300
@onready var animations = $Graphics
@export var total_hp = 6
@onready var current_hp = total_hp
@export var attack_dmg = 3
var gold = 0
var isHurt = false
var isAttacking = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
#hi

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	animate_player()
	handle_input()
	move_and_slide()
	
func animate_player():
	animations.flip_h = (velocity.x < 0)
	if (isAttacking || isHurt):
		pass
	elif velocity.length() == 0:
		animations.play("Idle")
	else:
		animations.play("Walk")
	
func handle_input():
	var direction = Input.get_vector("Left","Right","Up","Down")
	velocity = direction * speed
  
	if(direction.x < 0):
		animations.flip_h = true
	if(direction.x > 0):
		animations.flip_h = false
	if(direction != Vector2.ZERO):
		animations.play("Walk")
	else:
		animations.play("Idle")
		
	if Input.is_action_just_pressed("Attack"):
		animations.play("Attack_01")
		isAttacking = true
		await animations.animation_finished
		isAttacking = false


func take_damage(dmg):
	current_hp -= dmg
	if current_hp <= 0:
		die()
	animations.play("Hurt")
	isHurt = true
	await animations.animation_finished
	isHurt = false


func die():
	get_tree().reload_current_scene()


func update_gold(amt):
	gold += amt
