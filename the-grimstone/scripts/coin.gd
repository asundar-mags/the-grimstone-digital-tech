extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.fire_coin == true:
		queue_free()
