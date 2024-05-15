extends Node2D

@onready var player = $EntityContainer/Player

func _physics_process(_delta):
	Globals.player_pos = player.global_position
