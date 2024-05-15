class_name LargeEnemy
extends AdvanceEnemyMovement


@onready var direction_timer = $DirectionTimer as Timer
@onready var animated_sprite_2d = $AnimatedSprite2D as AnimatedSprite2D

var dir
var swim_idle : bool = true
var sprint_speed : float = 4000.0
var normal_speed : float = 1000.0
var fish_direction : Vector2

const FRAME_SPEED_SCALE : float = 0.5


func _ready():
	if swim_idle == true:
		random_generate()


func _physics_process(delta):
	if swim_idle == true:
		match current_stats:
			enemy_states.UP:
				move_up(delta)
			enemy_states.RIGHT:
				move_right(delta)
			enemy_states.DOWN:
				move_down(delta)
			enemy_states.LEFT:
				move_left(delta)
			enemy_states.UPRIGHT:
				move_upright(delta)
			enemy_states.DOWNRIGHT:
				move_downright(delta)
			enemy_states.DOWNLEFT:
				move_downleft(delta)
			enemy_states.UPLEFT:
				move_upleft(delta)
	elif swim_idle == false:
		fish_direction = (Globals.player_pos - self.global_position).normalized()
		velocity = fish_direction * speed * delta
	else:
		return
	
	swim_animation()
	
	move_and_slide()


func random_generate() -> void:
	dir = randi() % 8
	random_direction()


func random_direction() -> void:
	match dir:
		0:
			current_stats = enemy_states.UP
		1:
			current_stats = enemy_states.RIGHT
		2:
			current_stats = enemy_states.DOWN
		3:
			current_stats = enemy_states.LEFT
		4:
			current_stats = enemy_states.UPRIGHT
		5:
			current_stats = enemy_states.DOWNRIGHT
		6:
			current_stats = enemy_states.DOWNLEFT
		7:
			current_stats = enemy_states.UPLEFT


func swim_animation() -> void:
	if velocity == Vector2.ZERO:
		animated_sprite_2d.play("idle")
	else:
		animated_sprite_2d.play("move")
	
	self.rotation = velocity.angle()


func _on_direction_timer_timeout():
	random_generate()
	direction_timer.start()


func _on_chase_start_area_body_entered(body):
	if body is Player:
		swim_idle = false
		speed = sprint_speed
		animated_sprite_2d.speed_scale += FRAME_SPEED_SCALE


func _on_chase_end_area_body_exited(body):
	if body is Player:
		swim_idle = true
		speed = normal_speed
		animated_sprite_2d.speed_scale = FRAME_SPEED_SCALE


func _on_hitbox_body_entered(body):
	if "hurtbox" in body and body is Player:
		body.hurtbox()
