extends Node2D

@export var money: int = 250


func _ready() -> void:
	$Money.text = "Money: $" + str(money)
