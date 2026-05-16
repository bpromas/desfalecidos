extends Node2D

var direction
var target_time
var speed = 256
var time_alive = 0
var hittable = true

signal missed

@onready var label: Label = $Label
@onready var sprite: Sprite2D = $Sprite2D

var direction_vector = {
	"up": Vector2.UP,
	"right": Vector2.RIGHT,
	"down": Vector2.DOWN,
	"left": Vector2.LEFT,
}

var rotation_direction = {
	"up": deg_to_rad(0),
	"right": deg_to_rad(90),
	"down": deg_to_rad(180),
	"left": deg_to_rad(270),
}

var texture_direction = {
	"up": 'setinha cima',
	"right": 'setinha direita',
	"down": 'setinha baixo',
	"left": 'setinha esquerda',
}

func hit():
	if(!hittable): return
	hittable = false
	
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.5, 1.5), 0.15)
	tween.parallel().tween_property(self, "modulate:a", 0.0, 0.15)
	tween.tween_callback(queue_free)

func _ready():
	#rotation = rotation_direction[direction] 
	sprite.texture = load('res://assets/setinhas/'+texture_direction[direction]+'.png')
	sprite.scale = Vector2(0.05, 0.05)
	#sprite.modulate = Color.from_hsv(rotation, 1.0, 1.0, 1.0)

func _process(delta):
	position += direction_vector[direction] * speed * delta
	
	time_alive += delta
	if time_alive >= 1.5:
		missed.emit()
		queue_free()
	label.text = str(target_time)
