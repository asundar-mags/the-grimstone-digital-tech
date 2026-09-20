extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Clears air coin when player re-enters the scene, to avoid confusion
	if Global.air_coin == true:
		queue_free()
