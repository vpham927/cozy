extends Node2D

@onready var player_scene = preload("res://Player.tscn")

func _ready() -> void:
	var player = player_scene.instantiate()
	add_child(player)
	player.global_position = Vector2(0, 0)
