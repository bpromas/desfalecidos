extends Node2D

@onready var rhythm_game: Node2D = $"../Path2D/PathFollow2D/Camera2D/RhythmGame"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rhythm_game.broke_combo.connect(_on_broke_combo)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_broke_combo():
	animated_sprite_2d.play("sad")
	await get_tree().create_timer(1.0).timeout
	animated_sprite_2d.play("playing")
	
