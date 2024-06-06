extends CharacterBody2D
class_name Player
@export var speed = 300
@onready var animations = $Graphics
@export var total_hp = 6
@onready var current_hp = total_hp
@export var attack_dmg = 2
@onready var gold_ui = get_node("/root/World/UI/Gold")
@onready var HP_ui = get_node("/root/World/UI/HP_Control/HP")
var gold = 0
var isHurt = false
var isAttacking = false
var hittables_right = []
var hittables_left = []
var slimes = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	HP_ui.play(str(current_hp))
	gold_ui.set_text("Gold: " + str(gold))
	Dialogic.signal_event.connect(_on_dialogic_signal)
#hi

func _on_dialogic_signal(argument: String):
	if argument == "Pay for inn":
		update_gold(-5)
		heal(total_hp)
	
	if argument == "SQ_Complete":
		update_gold(15)

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
	if Dialogic.current_timeline != null:
		velocity = Vector2()
		return
	var direction = Input.get_vector("Left","Right","Up","Down")
	velocity = direction * speed
		
	if Input.is_action_just_pressed("Attack"):
		animations.play("Attack_01")
		#if animations.flip_h:
			#for area in hittables_left:
				#if area.get_parent() is Enemy:
					#area.get_parent().take_damage(attack_dmg)
		#else:
			#for area in hittables_right:
				#if area.get_parent() is Enemy:
					#area.get_parent().take_damage(attack_dmg)
		if animations.flip_h:
			for area in $Hurtbox_left.get_overlapping_areas():
				if area.get_parent() is Enemy:
					area.get_parent().take_damage(attack_dmg)
		else:
			for area in $Hurtbox_right.get_overlapping_areas():
				if area.get_parent() is Enemy:
					area.get_parent().take_damage(attack_dmg)
		isAttacking = true
		await animations.animation_finished
		isAttacking = false

func take_damage(dmg):
	current_hp -= dmg
	if current_hp <= 0:
		die()
	HP_ui.play(str(current_hp))
	animations.play("Hurt")
	isHurt = true
	await animations.animation_finished
	isHurt = false


func die():
	get_tree().reload_current_scene()


func update_gold(amt):
	gold += amt
	gold_ui.set_text("Gold: " + str(gold))


func heal(amt):
	current_hp += amt
	if current_hp >= total_hp:
		current_hp = total_hp
	HP_ui.play(str(current_hp))
	
func SQ():
	slimes -= 1
	if slimes == 0:
		Dialogic.VAR.SQ_Complete = true
#func _on_hurtbox_left_body_entered(body):
	#if body is Area2D:
		#hittables_left.append(body)
#
#
#func _on_hurtbox_left_body_exited(body):
	#if body in hittables_left:
		#hittables_left.remove_at(hittables_left.find(body))
#
#func _on_hurtbox_right_body_entered(body):
	#if body is Area2D:
		#hittables_right.append(body)
#
#
#func _on_hurtbox_right_body_exited(body):
	#if body in hittables_right:
		#hittables_right.remove_at(hittables_right.find(body))
