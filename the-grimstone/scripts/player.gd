extends CharacterBody2D

# Variables to refer to certain entities for functions such as on contact
@export var player: CharacterBody2D
@export var Respawn: Marker2D
@export var coin: Area2D
@export var timer: Timer

# Variable to define certain shapes that exist on the player to hide them (Polygon 2Ds)
@export var red: Polygon2D
@export var blue: Polygon2D
@export var green: Polygon2D
@export var yellow: Polygon2D

# Maximum number of jumps and amount of jumps left
@export var max_jumps: int = 1
var jumps_left: int = 1

# Constants used for replacing magic strings
const NEUTRAL_LEVEL: String = "neutral"
const ZERO: int = 0
const ONE: int = 1
const TWO: int = 2
const THREE: int = 3
const FOUR: int = 4

# Variables for player movement and momentum
const JUMP_VELOCITY = -600.0
const SPEED = 300.0
const SLIDE_FRICTION = 0.15

# Function that is constantly running
func _ready() -> void:
	# Code to make my player spawn at its respective marker
	if Global.change_spawn and get_parent().name == NEUTRAL_LEVEL:
		global_position = Global.spawn
	
	# Red colour on player visibility depending on if fire coin is collected
	if Global.fire_coin == true:
		red.show()
	elif Global.fire_coin == false:
		red.hide()
	
	# Green colour on player visibility depending on if earth coin is collected
	if Global.earth_coin == true:
		green.show()
	elif Global.earth_coin == false:
		green.hide()
	
	# Blue colour on player visibility depending on if water coin is collected
	if Global.water_coin == true:
		blue.show()
	elif Global.water_coin == false:
		blue.hide()
		
	# Yellow colour on player visibility depending on if air coin is collected
	if Global.air_coin == true:
		yellow.show()
	elif Global.air_coin == false:
		yellow.hide()
	
	# Validation of whether the game is completed for labels, timers and beating the game overall
	if Global.coins_collected == FOUR:
		Global.game_complete = true
	elif Global.coins_collected > FOUR:
		Global.game_complete = false

# Function that refers to the physics of the character (movement)
func _physics_process(delta: float) -> void:
	# Adds the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		# Resets jumps when player touches the ground
		jumps_left = max_jumps

	# Handles jump.
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			# Regular jump from the ground
			velocity.y = JUMP_VELOCITY
			jumps_left -= ONE
		elif jumps_left > ZERO:
			# Double jump activates once in air
			velocity.y = JUMP_VELOCITY
			jumps_left -= ONE

	# Adds movement when keybinds are pressed
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		# Speed of the character slows down in percentiles
		velocity.x = lerp(velocity.x, 0.0, SLIDE_FRICTION)
		
		# Code to avoid the percentage getting irrational or way to small over time, rather stops the character once he is slower than 1.0 px/s
		if abs(velocity.x) < float(ONE):
			velocity.x = ZERO
	
	# When escape is pressed, user returns to title screen with progress saved, unless they close the game
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://scenes/main menu.tscn")
		
	move_and_slide()

# Function for player taking damage from spikes
func _spike_take_damage(body: CharacterBody2D) -> void:
	get_tree().call_deferred("reload_current_scene")

# Function for redirection of player to fire scene
func _fire_map_entry(body: CharacterBody2D) -> void:
	Global.spawn = Global.exits[ZERO].global_position # Spawn has been set to first Marker2D in Spawn (Node2D)
	get_tree().change_scene_to_file("res://scenes/firemap.tscn")

# Function for redirection of player to air scene
func _air_map_entry(body: CharacterBody2D) -> void:
	Global.spawn = Global.exits[ONE].global_position # Spawn has been set to second Marker2D in Spawn (Node2D)
	get_tree().change_scene_to_file("res://scenes/airmap.tscn")

# Function for redirection of player to water scene
func _water_map_entry(body: CharacterBody2D) -> void:
	Global.spawn = Global.exits[THREE].global_position # Spawn has been set to fourth Marker2D in Spawn (Node2D)
	get_tree().change_scene_to_file("res://scenes/watermap.tscn")

# Function for redirection of player to earth scene
func _earth_map_entry(body: CharacterBody2D) -> void:
	Global.spawn = Global.exits[TWO].global_position # Spawn has been set to third Marker2D in Spawn (Node2D)
	get_tree().change_scene_to_file("res://scenes/earthmap.tscn")

# As player leaves fire map, he redirects to neutral level to relative spawn point
func _fire_map_exit(body: CharacterBody2D) -> void:
	Global.change_spawn = true # New spawn point, not original spawn, is true
	get_tree().change_scene_to_file("res://scenes/neutral level.tscn")

# As player leaves earth map, he redirects to neutral level to relative spawn point
func _earth_map_exit(body: CharacterBody2D) -> void:
	Global.change_spawn = true # New spawn point, not original spawn, is true
	get_tree().change_scene_to_file("res://scenes/neutral level.tscn")
	
# As player leaves water map, he redirects to neutral level to relative spawn point
func _water_map_exit(body: CharacterBody2D) -> void:
	Global.change_spawn = true # New spawn point, not original spawn, is true
	get_tree().change_scene_to_file("res://scenes/neutral level.tscn")

# As player leaves air map, he redirects to neutral level to relative spawn point
func _air_map_exit(body: CharacterBody2D) -> void:
	Global.change_spawn = true # New spawn point, not original spawn, is true
	get_tree().change_scene_to_file("res://scenes/neutral level.tscn")

# The process after player collects the fire coin*
func _fire_coin_collected(body: CharacterBody2D) -> void:
	Global.coins_collected += ONE # Amount of coins collected has increased by one
	Global.fire_coin = true # Fire coin has been collected is true
	body.global_position = Respawn.global_position # Player is sent to the respawn point (Marker2D)
	coin.queue_free() # Coin is deleted

# The process after player collects the air coin*
func _air_coin_collected(body: CharacterBody2D) -> void:
	Global.coins_collected += ONE # Amount of coins collected has increased by one
	Global.air_coin = true # Air coin has been collected is true
	body.global_position = Respawn.global_position # Player is sent to the respawn point (Marker2D)
	coin.queue_free() # Coin is deleted

# The process after player collects the earth coin*
func _earth_coin_collected(body: CharacterBody2D) -> void:
	Global.coins_collected += ONE # Amount of coins collected has increased by one
	Global.earth_coin = true # Earth coin has been collected is true
	body.global_position = Respawn.global_position # Player is sent to the respawn point (Marker2D)
	coin.queue_free() # Coin is deleted

# The process after player collects the water coin*
func _water_coin_collected(body: CharacterBody2D) -> void:
	Global.coins_collected += ONE # Amount of coins collected has increased by one
	Global.water_coin = true # Water coin has been collected is true
	body.global_position = Respawn.global_position # Player is sent to the respawn point (Marker2D)
	coin.queue_free() # Coin is deleted

# Function for game sequence initiation which starts a timer if criteria is met
func _game_over_sequence(body: CharacterBody2D) -> void:
	if Global.game_complete == true and body.is_in_group("player"):
		timer.start() # The timer starts

# Function when timer ends, which relocates player to game over screen
func _game_over_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/game_over_screen.tscn")
	
