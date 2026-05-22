extends Node2D
@onready var chara = $"bunni!"
@onready var bar = $ProgressBar
var time = 0

var shipa = preload("res://level/ship.tscn")
var clouda = preload("res://level/clod.tscn")
var blona = preload("res://level/character_body_2d.tscn")

var type = randf()
# Called when the node enters the scene tree for the first time.
func _ready():
	if randf() < 0.2:
		add_child(blona.instantiate())
	add_child(shipa.instantiate())
	add_child(clouda.instantiate())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	bar.value = chara.airmeter
	if chara.kms == 1:
		get_tree().quit()

func _on_timer_tier_1_timeout():
	time += 1
	if randf() < 0.15:
		add_child(blona.instantiate())
	add_child(shipa.instantiate())
	if time >= 30:
		get_node("TimerTier1").stop()
		get_node("TimerTier2").start()

func _on_timer_tier_2_timeout():
	time += 1
	if randf() < 0.2:
		add_child(blona.instantiate())
	add_child(shipa.instantiate())
	if time >= 60:
		get_node("TimerTier2").stop()
		get_node("TimerTier3").start()
	
func _on_timer_tier_3_timeout():
	if randf() < 0.25:
		add_child(blona.instantiate())
	add_child(shipa.instantiate())

func _on_timer_cloud_timeout():
	add_child(clouda.instantiate())
