class_name FinishLine
extends Area2D

@export var next_level_location : String


func _on_body_entered(body):
	if body is Player:
		body.set_physics_process(false)
		
		await get_tree().create_timer(4.5).timeout
		TransitionLayer.change_scene(next_level_location)
