class_name Player
extends CharacterBody2D

@onready var animation_player = $AnimationPlayer as AnimationPlayer
@onready var sprite_2d = $Sprite2D as Sprite2D
@onready var gpu_particles_2d = $Particles/GPUParticles2D as GPUParticles2D
@onready var collision_shape_2d = $CollisionShape2D as CollisionShape2D
@onready var revive_timer = $ReviveTimer as Timer

@export var acceleration_speed : float = 0.0
@export var deceleration_speed : float = 0.0
@export var move_speed : float = 5000.0

var player_position : Vector2
var damage_taken : bool = false


func _ready():
	player_position = self.global_position
	
	if velocity == Vector2.ZERO:
		animation_player.play("idle")


func _physics_process(delta):
	look_at_mouse_position()
	handle_acceleration(delta)
	handle_animation()
	
	move_and_slide()

func look_at_mouse_position() -> void:
	var mouse_position : Vector2 = get_global_mouse_position()
	
	look_at(mouse_position)

func handle_acceleration(delta) -> void:
	if Input.is_action_pressed("move"):
		velocity = velocity.move_toward(transform.x * move_speed * delta, acceleration_speed)
		return
	
	velocity = velocity.move_toward(Vector2.ZERO, deceleration_speed)

func handle_animation() -> void:
	if velocity == Vector2.ZERO:
		animation_player.play("idle")
		gpu_particles_2d.emitting = false
	else:
		animation_player.play("move")
		gpu_particles_2d.emitting = true

func hurtbox() -> void:
	gpu_particles_2d.emitting = false
	damage_taken = true
	Globals.player_alive = false
	if damage_taken == true:
		set_physics_process(false)
		animation_player.play("die")
		damage_taken = not damage_taken
		collision_shape_2d.set_deferred("disabled", true)
		await animation_player.animation_finished
		revive_timer.start()


func revive() -> void:
	damage_taken = false
	Globals.player_live -= 1
	sprite_2d.modulate = Color("ffffff")
	self.global_position = player_position
	velocity = Vector2.ZERO
	await get_tree().create_timer(0.3).timeout
	set_physics_process(true)
	
	print(Globals.player_live)


func _on_revive_timer_timeout():
	revive()
	Globals.player_alive = true
	await get_tree().create_timer(0.1).timeout
	collision_shape_2d.disabled = false













