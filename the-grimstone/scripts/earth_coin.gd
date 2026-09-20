extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Clears earth coin when player re-enters the scene, to avoid confusion
	if Global.earth_coin == true:
		queue_free()
