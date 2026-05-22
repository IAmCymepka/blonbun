extends CharacterBody2D
var bounced = 0
var coords2 = randf_range(4, 652)

# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = coords2
	position.y = -64


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y = 6000 * delta
	move_and_slide()
	


func _on_visible_on_screen_notifier_2d_screen_exited():
	self.queue_free()
