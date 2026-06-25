extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	var tween = get_tree().create_tween()
	tween.set_loops()

	tween.tween_property(self, "skew", deg_to_rad(5), 0.5)
	tween.tween_property(self, "skew", deg_to_rad(-5), 1.0)
	tween.tween_property(self, "skew", 0.0, 0.5)
