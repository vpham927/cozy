# Extends the Nodestate class from node_state.gd
extends NodeState


@export var player : Player
@export var animated_sprite_2d : AnimatedSprite2D

func _on_process(_delta : float) -> void:
	pass

func _on_physics_process(_delta : float) -> void:	
	if player.player_direction ==  Vector2.UP:
		animated_sprite_2d.play("idle_back")
	elif player.player_direction == Vector2.DOWN:
		animated_sprite_2d.play("idle_front")
	elif player.player_direction == Vector2.LEFT:
		animated_sprite_2d.play("idle_left")
	elif player.player_direction == Vector2.RIGHT:
		animated_sprite_2d.play("idle_right")
	else:
		# If the direction is not set, play the idle_front animation
		animated_sprite_2d.play("idle_front")

func _on_next_transitions() -> void:
	GameInputEvents.movement_input()

	if GameInputEvents.is_movement_input():
		transition.emit("walk")

	#Check if the current tool the player has is AxeWood
	if player.current_tool == DataTypes.Tools.AxeWood && GameInputEvents.use_tool():
		transition.emit("chopping")

	#Check if the current tool the player has is TillGround
	if player.current_tool == DataTypes.Tools.TillGround && GameInputEvents.use_tool():
		transition.emit("tilling")
		
	#Check if the current tool the player has is TillGround
	if player.current_tool == DataTypes.Tools.WaterCrops && GameInputEvents.use_tool():
		transition.emit("watering")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animated_sprite_2d.stop()
