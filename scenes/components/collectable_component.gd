class_name CollectableComponent
extends Area2D


@export var collectable_name: String


# If the body of this component enters with the player then collect
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("collected")
		# Because we use components we will be attaching this to another object so we juse get_parent
		get_parent().queue_free()
