extends Character
class_name NPC
@onready var attack_dmg = 1
@export var speed = 50
@onready var range = 150
@export var isFighting = false
@export var SQ = false
var gold = randi() % 7 + 1
var target


# Called when the node enters the scene tree for the first time.
func _ready():
	dead.connect(_on_death)
	hit.connect(_on_hit)
	target = player.character
	$Hurtbox_right.body_entered.connect(_on_Hurtbox_right_body_entered)
	$Hurtbox_left.body_entered.connect(_on_Hurtbox_left_body_entered)
	pass # Replace with function body.

func _physics_process(delta):
	if isFighting:
		if (update_velocity() > 20 && update_velocity() < range):
			move(velocity)
	else:
		pass

func _on_hit(origin):
	target = origin
	isFighting = true

func update_velocity():
	var dir
	if (target != null):
		dir = target.get_global_position()
	else:
		dir = global_position
	velocity = global_position.direction_to(dir) * speed
	return global_position.distance_to(dir)

func _on_death():
	player.update_gold(gold)
	if SQ:
		player.SQ()
	queue_free()

func _on_Hurtbox_right_body_entered(body):
	$Graphics.flip_h = false
	if body is Character && isFighting:
		attack(attack_dmg)

func _on_Hurtbox_left_body_entered(body):
	$Graphics.flip_h = true
	if body is Character &&isFighting:
		attack(attack_dmg)
