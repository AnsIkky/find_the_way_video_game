class_name HUD
extends CanvasLayer


@onready var live_bar = $LiveContainer/LiveBar as TextureProgressBar


func _process(_delta):
	update_live_bar()


func update_live_bar() -> void:
	live_bar.max_value = Globals.max_lives
	live_bar.value = Globals.player_live
