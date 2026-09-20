extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Clears fire coin when player re-enters the scene, to avoid confusion
	if Global.fire_coin == true:
		queue_free()
	
