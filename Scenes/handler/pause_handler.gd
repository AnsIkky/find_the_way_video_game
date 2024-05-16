extends CanvasLayer

@onready var pause_ui = $PauseUi

var can_pause : bool = true
var pause_status : bool = false


func _ready():
	pause_ui.hide()


func _process(_delta):
	if Input.is_action_just_pressed("pause_button") and can_pause == true:
		pause_status = !pause_status
		
		if pause_status == true:
			pause_ui.show()
			get_tree().paused = true
		else:
			pause_ui.hide()
			get_tree().paused = false
