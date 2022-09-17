extends KinematicBody2D


func _ready():
	pass
extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 500.0
var damage = 1

onready var Explosion = load(res://Effects/Explosion.tscn) 
var Effects = null

func _ready():
	velocity = Vector2(0,-speed).rotated(rotation)

func _physics_process(_delta):
	velocity = move_and_slide(velocity, Vector2.ZERO)
	position.x = wrapf(position.x, 0, 1024)
	position.y = wrapf(position.y, 0, 600)
	


func _on_Area2D_body_entered(body):
	if body.has_method("damage"):
		body.damage(damage)
	Effects = get_node_or_null("/root/Game/Effects")
	if Effects != null:  
		var explosions = Explosion.instance()
		Effects.add_child (explosion)
		explosion.global_position = self.global.position 
	queue_free()


func _on_Timer_timeout():
	var Player = get_node_or_null("/root/Player_Container/Player")
	Effects = get_node_or_null("/root/Game/Effects")
	if Player != null and Effects != null: 
	var bullet = Bullet.instance()
	var d = global_position.angle_to_point(Player.global_position)
	Effects.add_child(bullet)
	bullet.roation = d 
	bullet.global_position = global_posotion + Vector2(0,-40).rotated(d)
	queue_free()


func _on_Area2D_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	pass # Replace with function body.
