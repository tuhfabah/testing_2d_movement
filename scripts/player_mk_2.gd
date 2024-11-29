class_name PlayerMk_2 extends CharacterBody2D


const WALK_SPEED: float = 600.0
const ACCELERATION_SPEED: float = WALK_SPEED * 4.0

const JUMP_VELOCITY: float = -1000
const TERMINAL_VELOCITY: int = 1500

var gravity: float = ProjectSettings.get("physics/2d/default_gravity") * 2.0
@onready var platform_detector := $PlatformDetector as RayCast2D
@onready var sprite:= $Sprite2D as Sprite2D
@onready var camera := $Camera as Camera2D
var _double_jump_charged := false
var _allow_double_jump:= false

func _physics_process(delta: float) -> void:
	reset_jump()
		
	handle_jump_button()
	
	apply_gravity(delta)
	
	apply_horizontal_movement(delta)
	
#	apply_sprite_facing()
	
	floor_stop_on_slope = not platform_detector.is_colliding()
	move_and_slide()
	
func reset_jump() -> void:
	if is_on_floor():
		_double_jump_charged = true
		
func handle_jump_button() -> void:
	if Input.is_action_just_pressed("jump"):
		try_jump()
	elif Input.is_action_just_released("jump") and velocity.y < 0.0:
		velocity.y *= 0.6
	
func try_jump() -> void:
	if is_on_floor():
		pass
	elif _double_jump_charged and _allow_double_jump:
		_double_jump_charged = false
		velocity.x *= 1.5
	else:
		return
	velocity.y = JUMP_VELOCITY
	
func apply_gravity(delta: float) -> void:
	var falling_velocity := velocity.y + (gravity * delta)
	velocity.y = minf(TERMINAL_VELOCITY, falling_velocity)

func apply_horizontal_movement(delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	var x_velocity_application := direction * WALK_SPEED

	velocity.x = move_toward(velocity.x, x_velocity_application, ACCELERATION_SPEED * delta)
	
func apply_sprite_facing() -> void:
	if not is_zero_approx(velocity.x):
		if velocity.x > 0.0:
			sprite.scale.x = 1.0
		else:
			sprite.scale.x = -1.0
