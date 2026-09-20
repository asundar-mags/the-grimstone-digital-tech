extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Function for button once pressed to return character to the title screen
func _exit_back_to_title_screen() -> void:
	get_tree().change_scene_to_file("res://scenes/main menu.tscn")
