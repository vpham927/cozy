extends CharacterBody2D

@export var speed: float = 200.0

@onready var sprite: = $Sprite

#Code to handle movement

func _physics_process(delta: float) -> void:
	var direction: Vector2 = Vector2.ZERO

	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1


	#Normalize for Diagonal Movement. Pythagorean Theorem. 
	direction = direction.normalized()
	velocity = direction * speed

	move_and_slide()
	
	if direction == Vector2.ZERO:
		sprite.stop()
	else:
		if abs(direction.x) > abs(direction.y):
			sprite.play("walk_right" if direction.x > 0 else "walk_left")
		else:
			sprite.play("walk_down" if direction.y > 0 else "walk_up")
