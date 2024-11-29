extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	apply_central_impulse(Vector2(1000, -300))
	apply_torque_impulse(800000)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
#	constant_force = Vector2(500,0)
	print(angular_velocity)



func _on_body_entered(body:Node) -> void:
	pass
