extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
var direction = Input.get_axis("Move_Left", "Move_Right")
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var keystrokes = []
@export var fireball_scene = preload("res://Scenes/fireball.tscn")
@onready var animated_sprite = $AnimatedSprite2D
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	direction = Input.get_axis("Move_Left", "Move_Right")
	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction: -1, 0, 1

	
	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("Idle")
#		else:
#			animated_sprite.play("Run")
#	else:
#		animated_sprite.play("Jump")
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	listen_keystrokes()
func _process(delta):
	if Input.is_action_just_pressed("fire"):
		shoot_fireball()
	# Listen to arrow keystrokes when Ctrl is pressed
func listen_keystrokes():
	if Input.is_action_pressed("Listen"):
		if Input.is_action_just_pressed("Spell_Left"):
			keystrokes.append("Left")
			
		if Input.is_action_just_pressed("Spell_Right"):
			keystrokes.append("Right")
			
		if Input.is_action_just_pressed("Spell_Up"):
			keystrokes.append("Up")
			
		if Input.is_action_just_pressed("Spell_Down"):
			keystrokes.append("Down")
			
	if keystrokes.size() == 6:
		print("Spell casted!")
		print(keystrokes)
		cast_spell()
func cast_spell():
	if keystrokes.size() > 0 and keystrokes.size() <= 6:
		print("Casting spell with keystrokes: ", keystrokes)
		#keystrokes.clear()
	if keystrokes[0] == "Up" and keystrokes[1] == "Up":
		print("Casting Fireball!")
		shoot_fireball()
		print("No keystrokes to cast a spell.")
	else:
		print("No keystrokes to cast a spell.")


func shoot_fireball():
		var fireball = fireball_scene.instantiate()
		fireball.position = position
		#fireball.direction = $AnimatedSprite2D * Vector2.RIGHT  # Assuming the player faces right with positive scale
		fireball.velocity = Vector2(500, 0) # Set the initial velocity of the fireball
		get_parent().add_child(fireball)
		print("Fireball shot!")
#TODO Add the fireball to the scene
