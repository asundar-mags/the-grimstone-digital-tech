extends CharacterBody2D

@export var player: CharacterBody2D
@export var Respawn: Marker2D
@export var coin: Area2D

var neutral_level: String = "neutral"
var initial: int = 0
var second: int = 1
var third: int = 2
var fourth: int = 3

const SPEED = 300.0
const JUMP_VELOCITY = -500.0

func _ready() -> void:
	if Global.change_spawn and get_parent().name == neutral_level:
		global_position = Global.spawn

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()
	
func _spike_take_damage(body: CharacterBody2D) -> void:
	get_tree().call_deferred("reload_current_scene")
	
func _fire_map_entry(body: CharacterBody2D) -> void:
	Global.spawn = Global.exits[initial].global_position
	get_tree().change_scene_to_file("res://scenes/firemap.tscn")

func _air_map_entry(body: CharacterBody2D) -> void:
	get_tree().change_scene_to_file("res://scenes/airmap.tscn")

func _water_map_entry(body: CharacterBody2D) -> void:
	get_tree().change_scene_to_file("res://scenes/watermap.tscn")

func _earth_map_entry(body: CharacterBody2D) -> void:
	Global.spawn = Global.exits[third].global_position
	get_tree().change_scene_to_file("res://scenes/earthmap.tscn")

func _fire_map_exit(body: CharacterBody2D) -> void:
	Global.change_spawn = true
	get_tree().change_scene_to_file("res://scenes/neutral level.tscn")

func _earth_map_exit(body: CharacterBody2D) -> void:
	Global.change_spawn = true
	get_tree().change_scene_to_file("res://scenes/neutral level.tscn")

func _coin_collected(body: CharacterBody2D) -> void:
	Global.coins_collected =+ 1
	Global.fire_coin = true
	body.global_position = Respawn.global_position
	coin.queue_free()
	
