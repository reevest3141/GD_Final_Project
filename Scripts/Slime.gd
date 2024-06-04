extends CharacterBody2D
@onready var player_character = get_node("/root/World/Game Manager/Player")
@export var speed = 100
@export var damage = 2
@export var total_hp = 2
@onready var current_hp = total_hp
var gold = randi() % 5 + 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	if (update_velocity() > 20):
		move_and_slide()


func update_velocity():
	var target = player_character.get_global_position()
	velocity = position.direction_to(target) * speed
	return position.distance_to(target)


func take_damage(dmg):
	current_hp -= dmg
	if current_hp <= 0:
		player_character.update_gold(gold)
		queue_free()


func _on_hitbox_body_entered(body):
	if body is Player:
		body.take_damage(damage)
	pass # Replace with function body.
