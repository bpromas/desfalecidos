extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start("depois_do_teste")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_timeline_ended():
	get_tree().change_scene_to_file("res://scenes/credits.tscn")
