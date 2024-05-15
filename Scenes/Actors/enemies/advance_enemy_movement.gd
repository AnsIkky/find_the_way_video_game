class_name AdvanceEnemyMovement
extends CharacterBody2D

var current_stats
enum enemy_states {UP, RIGHT, DOWN, LEFT, UPRIGHT, DOWNRIGHT, DOWNLEFT, UPLEFT}
var direction = 1

@export var speed : float = 1000.0

#region move_dir func
func move_up(delta : float) -> void:
	velocity = Vector2.UP * speed * direction * delta

func move_right(delta : float) -> void:
	velocity = Vector2.RIGHT * speed * direction * delta

func move_down(delta : float) -> void:
	velocity = Vector2.DOWN * speed * direction * delta

func move_left(delta : float) -> void:
	velocity = Vector2.LEFT * speed * direction * delta

func move_upright(delta : float) -> void:
	velocity = Vector2(1, -1) * speed * direction * delta * 0.7

func move_downright(delta : float) -> void:
	velocity = Vector2(1, 1) * speed * direction * delta * 0.7

func move_downleft(delta : float) -> void:
	velocity = Vector2(-1, 1) * speed * direction * delta * 0.7

func move_upleft(delta : float) -> void:
	velocity = Vector2(-1, -1) * speed * direction * delta * 0.7

#endregion
