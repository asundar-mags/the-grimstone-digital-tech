extends Node

@export var exits: Array[Node]
@export var coins_collected: int = 0
@export var fire_coin: bool = false

var spawn: Vector2
var change_spawn: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
