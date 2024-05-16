extends Node2D

@onready var label = $Label
@onready var timer = $Timer


func _process(delta):
	label.text = "%d : %02d" % [floor(timer.time_left / 60), int(timer.time_left) % 60]
