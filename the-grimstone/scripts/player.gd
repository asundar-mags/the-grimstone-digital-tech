extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -550.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _fire_map_entry(body: CharacterBody2D) -> void:
	get_tree().change_scene_to_file("res://scenes/firemap.tscn")


func _air_map_entry(body: CharacterBody2D) -> void:
	get_tree().change_scene_to_file("res://scenes/airmap.tscn")


func _water_map_entry(body: CharacterBody2D) -> void:
	get_tree().change_scene_to_file("res://scenes/watermap.tscn")


func _earth_map_entry(body: CharacterBody2D) -> void:
	get_tree().change_scene_to_file("res://scenes/earthmap.tscn")


func _fire_map_exit(body: CharacterBody2D) -> void:
	get_tree().change_scene_to_file("res://scenes/neutral level.tscn")
