extends CharacterBody2D

@export var acceleration: float = 60
var h_vel: float = 0
var friction: float = 50
@export var speed: float = 800.0
@export var jump_force: float = 700.0

@export var gravity_value: float = 2000.0
@export var terminal_velocity: int = 2000

var input_vector: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity_value * delta
		clamp(velocity.y, 0, terminal_velocity)
#		if velocity.y > terminal_velocity:
#			velocity.y = terminal_velocity

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_force

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction:
		h_vel += acceleration
		h_vel = min(h_vel, speed)
		velocity.x = direction * h_vel
	else:
		h_vel -= friction
		h_vel = max(h_vel, 0)
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
