extends Node

# Variables for each coin, an array of spawn points when entering neutral level, amount of coins collected, and whether the game is finished or not
@export var exits: Array[Node]
@export var coins_collected: int = 0
@export var game_complete: bool = false
@export var fire_coin: bool = false
@export var water_coin: bool = false
@export var earth_coin: bool = false
@export var air_coin: bool = false

# Variables to idenify spawn type and a boolean to make player spawn from the center
var spawn: Vector2
var change_spawn: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
