extends CharacterBody2D
class_name Player
 
const SPEED = 130.0
const JUMP_VELOCITY = -300.0
@onready var jump = $jump
@onready var hurt = $hurt

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = $AnimatedSprite2D
const GAME_OVER = preload("res://scenes/game_over.tscn")
@export_group("Camera sync")
@export var camera_sync: Camera2D
@export var should_camera_sync: bool = true 
@export_group("")
var knockback_vector = Vector2.ZERO
var is_dead = false

func _ready():
	# Ensure camera_sync is assigned
	if camera_sync == null:
		print("Warning: camera_sync is not assigned. Camera synchronization will be disabled.")
		should_camera_sync = false

func _physics_process(delta):
	if is_dead or not Global.can_move:
		return 
	
	if camera_sync and should_camera_sync:
		var camera_left_bound = camera_sync.global_position.x - camera_sync.get_viewport_rect().size.x / 2 / camera_sync.zoom.x

		# Prevent the character from moving off-screen to the left.
		if global_position.x < camera_left_bound + 8 and sign(velocity.x) == -1:
			velocity.x = 0

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jumpPlayer()

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("left", "right")
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	#funcao para disparar a morte
	if Global.player_life == 0:
		_game_over()
	move_and_slide()
	update_animations(direction)
	
	


func jumpPlayer():
	velocity.y = JUMP_VELOCITY
	jump.play()



func update_animations(direction):
	if is_on_floor():
		if direction != 0:
			anim.play("skip")
			anim.flip_h = direction < 0
		else:
			anim.play("idle")
	else:
		anim.play("jump")

func _process(delta):
	if should_camera_sync and camera_sync:
		camera_sync.global_position.x = lerp(camera_sync.global_position.x, global_position.x, 0.1)


func _on_hurtbox_body_entered(body):
	if body.is_in_group("enemies"):
		if $ray_right.is_colliding():
			take_damage(Vector2(-400, -100),0.25)
		elif $ray_left.is_colliding():
			take_damage(Vector2(400, -100),0.25)
		lose_life()

func take_damage(knockback_force : Vector2, duration : float):
	knockback_vector = knockback_force
	var knockback_tween = get_tree().create_tween()
	knockback_tween.tween_property(self, "velocity", knockback_vector, duration)
	modulate = Color.RED
	knockback_tween.tween_property(self, "modulate", Color(1,1,1,1), duration)
	

func lose_life():
	hurt.play()
	Global.player_life -= 1
	if Global.player_life <= 0:
		_game_over()
		

func _game_over():
	Global.index1 = 0
	var game_over_scene = load("res://scenes/game_over.tscn")
	var game_over = game_over_scene.instantiate()
	print("Game over")
	get_parent().add_child(game_over)
	queue_free()

# Function to play the hurt animation and set is_dead flag
func play_hurt_animation():
	is_dead = true
	anim.play("hurt")


