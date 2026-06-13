extends Node2D

@onready var rhythm_game: Node2D = $"../Path 1/PathFollow2D/Camera2D/RhythmGame"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rhythm_game.broke_combo.connect(_on_broke_combo)
	var tween = get_tree().create_tween()
	tween.set_loops()

	tween.tween_property(self, "skew", deg_to_rad(5), 0.5)
	tween.tween_property(self, "skew", deg_to_rad(-5), 1.0)
	tween.tween_property(self, "skew", 0.0, 0.5)

func _process(delta: float) -> void:
	pass

func _on_broke_combo():
	animated_sprite_2d.play("sad")
	await get_tree().create_timer(1.0).timeout
	animated_sprite_2d.play("playing")
	
