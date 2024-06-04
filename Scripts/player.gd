extends CharacterBody2D
class_name Player
@export var speed = 300
@onready var animations = $Graphics
@export var total_hp = 6
@onready var current_hp = total_hp
@export var attack_dmg = 2
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
	animations.flip_h = true if velocity.x < 0 else false if velocity.x > 0 else animations.flip_h

	if (isAttacking || isHurt):
		pass
	elif velocity.length() == 0:
		animations.play("Idle")
	else:
		animations.play("Walk")
	
func handle_input():
	var direction = Input.get_vector("Left","Right","Up","Down")
	velocity = direction * speed
		
	if Input.is_action_just_pressed("Attack"):
		animations.play("Attack_01")
		if animations.flip_h:
			for area in $Hurtbox_left.get_overlapping_areas():
				if area.get_parent() is Enemy:
					area.get_parent().take_damage(attack_dmg)
		else:
			for area in $Hurtbox_right.get_overlapping_areas():
				if area.get_parent() is Enemy:
					area.get_parent().take_damage(attack_dmg)
		#meleeHurtBox = "Hurtbox_" + Input.actio
		#for area in meleeHurtBox.get_overlapping_areas():
			#if area is 
			#
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
