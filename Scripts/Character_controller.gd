extends CharacterBody2D
class_name Character
@onready var animations = $Graphics
@export var total_hp = 6
@onready var current_hp = total_hp
signal dead
var isAttacking = false
var isHurt = false
# Called when the node enters the scene tree for the first time.
func _ready():
	player.get_child(1).volume_db = -40.0
	Dialogic.signal_event.connect(_on_dialogic_signal)
	pass # Replace with function body.

func _on_dialogic_signal(argument: String):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	animate()

func animate():
	animations.flip_h = true if velocity.x < 0 else false if velocity.x > 0 else animations.flip_h
	if (isAttacking || isHurt):
		if animations.frame_progress == 1:
			isAttacking = false
			isHurt = false
		else:
			return
	if velocity.length() == 0:
		animations.play("Idle")
		player.get_child(1).volume_db = -40.0
	else:
		animations.play("Walk")
		player.get_child(1).volume_db = 10.0
		if(!player.get_child(1).playing):
			player.get_child(1).play()
@onready var player = get_node("/root/World/Game Manager/Player")
func move(direction : Vector2):
	velocity = direction
	move_and_slide()

func attack(dmg):
	player.get_child(2).play()
	animations.play("Attack_1")
	if animations.flip_h:
		for area in $Hurtbox_left.get_overlapping_areas():
			if area.get_parent() is Enemy || area.get_parent() is Boss:
				area.get_parent().take_damage(dmg)
	else:
		for area in $Hurtbox_right.get_overlapping_areas():
			if area.get_parent() is Enemy || area.get_parent() is Boss:
				area.get_parent().take_damage(dmg)
	isAttacking = true

func take_damage(dmg):
	if isHurt:
		return
	current_hp -= dmg
	animations.play("Hurt")
	isHurt = true
	if current_hp <= 0:
		dead.emit()
