extends CharacterBody3D

@export var mouse_sensitivity: float = 0.004
@onready var head: Node3D = $Head
@onready var eye_camera: Camera3D = $Head/EyeCamera



const SPEED = 5.0
const JUMP_VELOCITY = 4.5

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	var random = FastNoiseLite.new()

func _physics_process(delta: float) -> void:

	$CanvasLayer/BoxContainer/InteractText.hide()
	if %SeeCast.is_colliding():
		#print("Collidin")
		var target = %SeeCast.get_collider()
		if target != null and target.has_method("interact"):
			$CanvasLayer/BoxContainer/InteractText.show()
			if Input.is_action_just_pressed("interact"):
				target.interact()

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction := (eye_camera.global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	

	move_and_slide()
	
func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		var relative = event.relative * mouse_sensitivity
		head.rotate_y(-relative.x)
		eye_camera.rotate_x(relative.y)
		eye_camera.rotation.x = clamp(eye_camera.rotation.x, -0.7, 0.7)
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()


func _on_area_3d_body_entered(body: Node3D) -> void:
	get_tree().call_deferred("change_scene_to_file", "res://PartygoerFight.tscn")
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
