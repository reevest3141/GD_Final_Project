extends CharacterBody2D
@export var speed = 300
@onready var animations = $Graphics
@export var total_hp = 6
@onready var current_hp = total_hp
@export var attack_dmg = 3
var gold = 0
var anim_frames = 0

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
	if anim_frames > 0:
		anim_frames -= delta
	
func animate_player():
	animations.flip_h = (velocity.x < 0)
	if anim_frames > 0:
		return
	if velocity.length() == 0:
		animations.play("Idle")
	else:
		animations.play("Walk")
	
func handle_input():
	var direction = Input.get_vector("Left","Right","Up","Down")
	velocity = direction * speed
		
	if Input.is_action_just_pressed("Attack"):
		animations.play("Attack_01")
		anim_frames = 6
		pass


func take_damage(dmg):
	animations.play("Hurt")
	anim_frames = 4
	current_hp -= dmg
	if current_hp <= 0:
		die()


func die():
	get_tree().reload_current_scene()


func update_gold(amt):
	gold += amt
