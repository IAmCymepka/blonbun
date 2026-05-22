extends CharacterBody2D
@onready var sprite = $sprites
@onready var hitbox = $hhit
@onready var blonbox = $Area2D2
@onready var spritehead = $sprites/head
@onready var spritebody = $sprites/body
@export var airmeter = 2
@onready var walls = $CollisionShape2D
var dead = 0
const puff = 500
var rotation_accel = 0
var scalex = 1
@export var kms = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if airmeter > 0:
		
		if Input.is_action_pressed("left") && abs(rotation_accel) < 10:
			rotation_accel -= 7.5 * delta
		if Input.is_action_pressed("right") && abs(rotation_accel) < 10:
			rotation_accel += 7.5 * delta
		
		if rotation_accel < 0:
			rotation_accel += 2.5 * delta
		elif rotation_accel > 0:
			rotation_accel -= 2.5 * delta
		if abs(rotation_accel) <= .055:
			rotation_accel = 0
		sprite.rotation += rotation_accel * delta
		scalex = .5 + airmeter / 2
		if scalex < 0.75:
			scalex = .75
		scale = Vector2(scalex, scalex)
		
		#movement
		if Input.is_action_pressed("forward") && velocity.length() < 2500 && airmeter > 0:
			velocity += puff * delta * Vector2.UP.rotated(sprite.rotation)
			if airmeter > 5:
				airmeter = 5
			airmeter -= .1*delta
			spritebody.play("default")
		elif velocity.length() > 500 && airmeter > 0:
			velocity -= puff * .5 * delta * Vector2.from_angle(velocity.angle())
			spritebody.play("new_animation")
		else:
			velocity -= puff * .25 * delta * Vector2.from_angle(velocity.angle())
			spritebody.play("new_animation")
		
		#collision
		if hitbox.has_overlapping_bodies():
			get_node("iframes").start()
			hitbox.monitoring = false
			airmeter -= 1
			spritehead.play("puff")
		if blonbox.has_overlapping_bodies():
			get_node("bframes").start()
			blonbox.monitoring = false
			airmeter += 1
			if airmeter > 5:
				airmeter = 5
		
		
	if airmeter <= 0 && dead == 0:
		dead = 1
		spritebody.play("new_animation")
		spritehead.play("whoops")
		walls.disabled = true
		velocity = Vector2.ZERO
		get_node("dead").start()
	
	if dead == 2:
		velocity.y = -225
		velocity.x = -150
		dead = 3
	if dead == 3:
		velocity.y += 350 * delta
	move_and_slide()
	
	
func _on_iframes_timeout():
	if airmeter >0:
		hitbox.monitoring = true
		spritehead.play("idle")
func _on_bframes_timeout():
	if airmeter >0:
		blonbox.monitoring = true
func _on_dead_timeout():
	spritebody.play("new_animation_1")
	spritehead.play("die")
	dead = 2
	


func _on_visible_on_screen_notifier_2d_screen_exited():
	kms = 1
