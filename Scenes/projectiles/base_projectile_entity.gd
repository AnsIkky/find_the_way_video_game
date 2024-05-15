class_name BaseProjectileEntity
extends CharacterBody2D

@onready var sprite_2d = $Sprite2D as Sprite2D
@onready var gpu_particles_2d = $GPUParticles2D as GPUParticles2D
@onready var area_collision = $HitArea/AreaCollision as CollisionShape2D

var movement_speed : float = 0.0
var direction : Vector2 = Vector2.ZERO


func _process(delta):
	handle_movement(delta)


func handle_movement(delta : float) -> void:
	move_and_collide(direction * movement_speed * delta)


func set_speed(new_speed : float) -> void:
	movement_speed = new_speed


func set_direction(new_direction : Vector2) -> void:
	direction = new_direction


func set_texture(new_texture : Texture2D) -> void:
	sprite_2d.texture = new_texture


func _on_hit_area_body_entered(_body):
	area_collision.set_deferred("disabled", true)
	sprite_2d.visible = false
	movement_speed = 0.0
	gpu_particles_2d.emitting = false
	
	await get_tree().create_timer(1.0).timeout
	queue_free()


func _on_timer_timeout():
	area_collision.set_deferred("disabled", true)
	sprite_2d.visible = false
	movement_speed = 0.0
	gpu_particles_2d.emitting = false
	
	await get_tree().create_timer(1.0).timeout
	queue_free()
