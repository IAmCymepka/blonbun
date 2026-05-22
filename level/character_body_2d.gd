extends CharacterBody2D
@onready var area = $Area2D
var coords2 = randf_range(4, 652)

# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = coords2
	position.y = -64


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y = 4500 * delta
	move_and_slide()
	
	if area.has_overlapping_bodies():
		get_node("Timer").start()
		area.monitoring = false


func _on_visible_on_screen_enabler_2d_screen_exited():
	self.queue_free()


func _on_timer_timeout():
	self.queue_free()
