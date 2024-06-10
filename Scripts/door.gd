extends Area2D
class_name Door

var opened = false
# Called when the node enters the scene tree for the first time.
func _ready():
	opened = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_body_entered(body):
	if(body is Player and opened):
		print("new scene!")
		
