extends CharacterBody2D
class_name Enemy
@onready var player = get_node("/root/World/Game Manager/Player")
@export var speed = 100
@export var damage = 2
@export var total_hp = 4
@onready var current_hp = total_hp
@onready var animations = $Graphics
@export var SQ = false
var gold = randi() % 5 + 1
var target
var isHurt = false
var isAttacking = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Hurtbox_right.body_entered.connect(_on_hitbox_body_entered)
	$Hurtbox_left.body_entered.connect(_on_hitbox_body_entered)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	if (update_velocity() > 20 && update_velocity() < 50):
		move_and_slide()
	animate_enemy()

func update_velocity():
	target = player.character.get_global_position()
	velocity = position.direction_to(target) * speed
	return position.distance_to(target)


func take_damage(dmg):
	if isHurt:
		return
	current_hp -= dmg
	animations.play("Hurt")
	isHurt = true
	if current_hp <= 0:
		player.update_gold(gold)
		if SQ:
			player.SQ()
		queue_free()


func _on_hitbox_body_entered(body):
	if body is Player && !isHurt:
		animations.play("Attack")
		isAttacking = true
		body.take_damage(damage)
	pass # Replace with function body.


func animate_enemy():
	animations.flip_h = true if velocity.x < 0 else false if velocity.x > 0 else animations.flip_h
	if (isAttacking || isHurt):
		if animations.frame_progress == 1:
			isAttacking = false
			isHurt = false
		else:
			return
	elif velocity.length() == 0:
		animations.play("Idle")
	else:
		animations.play("Walk")
