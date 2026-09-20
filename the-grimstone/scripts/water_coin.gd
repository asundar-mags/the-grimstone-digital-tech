extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Clears water coin when player re-enters the scene, to avoid confusion
	if Global.water_coin == true:
		queue_free()
