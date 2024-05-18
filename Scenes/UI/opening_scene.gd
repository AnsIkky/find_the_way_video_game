extends CanvasLayer

@onready var label = $Label as Label
@onready var animation_player = $AnimationPlayer as AnimationPlayer

var line_status = [
	"Kotakan Sawah Production",
	"This game was created for the reason of participating\nin the Pixel Game Jam - 2024"
]


func _ready():
	animation_player.play("opening_animation")
	await animation_player.animation_finished
	
	TransitionLayer.change_scene("res://Scenes/Levels/title_screen.tscn")


func gamedev_name_text() -> void:
	label.text = line_status[0]

func info_text() -> void:
	label.text = line_status[1]
