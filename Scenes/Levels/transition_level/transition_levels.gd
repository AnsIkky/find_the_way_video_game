class_name TransitionLevels
extends CanvasLayer

@onready var label = $Label as Label

@export var level_text : String
@export var next_level_location : String

func _ready():
	label.text = level_text
	
	await get_tree().create_timer(4.0).timeout
	TransitionLayer.change_scene(next_level_location)
	
