extends Node2D

@export var spawn_points: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.exits = spawn_points.get_children()
	if Global.coins_collected == 1:
		print("Game Over")
		#get_tree().quit()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
