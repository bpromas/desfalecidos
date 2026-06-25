extends Node2D

@onready var rhythm_game: Node2D = $"../Path 1/PathFollow2D/Camera2D/RhythmGame"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var cpu_particles_2d = $CPUParticles2D

func _ready() -> void:
	cpu_particles_2d.emitting = false
	rhythm_game.broke_combo.connect(_on_broke_combo)
	var tween = get_tree().create_tween()
	tween.set_loops()

	tween.tween_property(self, "skew", deg_to_rad(5), 0.5)
	tween.tween_property(self, "skew", deg_to_rad(-5), 1.0)
	tween.tween_property(self, "skew", 0.0, 0.5)
	
func _process(delta):
	if(rhythm_game.combo >= 100):
		var t = (sin(Time.get_ticks_msec() * 0.005) + 1.0) / 2.0
		cpu_particles_2d.emitting = true
		animated_sprite_2d.modulate = Color.WHITE.lerp(Color.GOLD, t)
	elif(rhythm_game.combo >= 50):
		var t = (sin(Time.get_ticks_msec() * 0.005) + 1.0) / 4.0
		cpu_particles_2d.emitting = true
		animated_sprite_2d.modulate = Color.WHITE.lerp(Color.GOLD, t)
	elif(rhythm_game.combo >= 25):
		cpu_particles_2d.emitting = false
		var t = (sin(Time.get_ticks_msec() * 0.005) + 1.0) / 8.0
		animated_sprite_2d.modulate = Color.WHITE.lerp(Color.GOLD, t)
	elif(rhythm_game.combo >= 10):
		cpu_particles_2d.emitting = false
		var t = (sin(Time.get_ticks_msec() * 0.005) + 1.0) / 16.0
		animated_sprite_2d.modulate = Color.WHITE.lerp(Color.GOLD, t)
		
func _on_broke_combo():
	var tween = create_tween()
	cpu_particles_2d.emitting = false

	# Flash red
	animated_sprite_2d.modulate = Color.RED

	tween.parallel().tween_property(
		animated_sprite_2d,
		"modulate",
		Color.WHITE,
		0.3
	)
