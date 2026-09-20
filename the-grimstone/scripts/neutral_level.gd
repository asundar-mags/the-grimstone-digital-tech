extends Node2D

# Variables for labels and spawn points
@export var spawn_points: Node2D
@export var game_ended: Label
@export var game_start: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Collects the spawn points for my player when he leaves areas
	Global.exits = spawn_points.get_children()
	
	# Alternates labels based on if the player is early or finished the game
	if Global.game_complete == true:
		game_ended.show()
		game_start.hide()
	elif Global.game_complete == false:
		game_ended.hide()
		game_start.show()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
