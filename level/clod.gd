extends CharacterBody2D
@onready var cloud1 = $Sprite2D
@onready var cloud2 = $Sprite2D2
var getrand = randf()
var coords2 = randf_range(4, 652)

# Called when the node enters the scene tree for the first time.
func _ready():
	position.y = coords2
	position.x = 728
	if getrand < .5:
		cloud1.visible = false
	else:
		cloud2.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.x = -6000 * delta
	move_and_slide()
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
