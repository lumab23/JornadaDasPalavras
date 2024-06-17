extends Node2D

class_name Slime

var SPEED = 60
var direction = 1
@onready var ray_cast_right = $CharacterBody2D/RayCastRight
@onready var ray_cast_left = $CharacterBody2D/RayCastLeft
@onready var anim = $CharacterBody2D/AnimatedSprite2D



func _process(delta):
	if not Global.can_move:
		return  # Stop movement if can_move is false
	if ray_cast_right.is_colliding():
		direction = -1
		anim.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		anim.flip_h = false
	
	position.x += direction * SPEED * delta 

func dieEnemie():
	SPEED = 0
	anim.play("die")
	get_tree().create_timer(0.2).timeout.connect(queue_free)
	
func pausar():
	SPEED = 0

func iniciar():
	SPEED = 60



func _on_collision_body_entered(body):
	print("colidiu")
