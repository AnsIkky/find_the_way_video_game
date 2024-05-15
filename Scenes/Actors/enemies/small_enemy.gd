class_name SmallEnemy
extends AdvanceEnemyMovement


@onready var direction_timer = $DirectionTimer as Timer
@onready var animated_sprite_2d = $AnimatedSprite2D as AnimatedSprite2D

var dir


func _ready():
	random_generate()


func _physics_process(delta):
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


func _on_hit_box_body_entered(body):
	if "hurtbox" in body and body is Player:
		body.hurtbox()
