extends Sprite2D
@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent

var log_scene = preload("res://scenes/objects/trees/log.tscn")

func _ready() -> void:
	hurt_component.hurt.connect(on_hurt)
	damage_component.max_damage_reached.connect(on_max_damage_reached)
	
func on_hurt(hit_damage: int) -> void:
	damage_component.apply_damage(hit_damage)
	material.set_shader_parameter("shake_intensity", 2)
	await get_tree().create_timer(0.5).timeout
	material.set_shader_parameter("shake_intensity", 0.0)
	
func on_max_damage_reached() -> void:
	#We can't instantly spawn the log we must wait a frame
	call_deferred("add_log_scene")
	print("max damage reached")
	queue_free()

#Function for the call_deferred above	
func add_log_scene() -> void:
	var log_instance = log_scene.instantiate() as Node2D
	#We define the global position of the log on the small_tree object 
	log_instance.global_position = global_position
	
	get_parent().add_child(log_instance)
