extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Function when its button is pressed starts the game uo
func _play() -> void:
	get_tree().change_scene_to_file("res://scenes/neutral level.tscn")

# Function when the button is pressed, options, controls, help and other details are shown
func _options() -> void:
	get_tree().change_scene_to_file("res://scenes/controls.tscn")

# Function when its button is pressed quits the game
func _quit() -> void:
	get_tree().quit()
