extends Area2D

onready var animated_sprite = $AnimatedSprite
onready var rigid_body = get_node("RigidBody2D")
onready var rigid_body_collision_shape = get_node("RigidBody2D/CollisionShape2D")

func _ready():
	animated_sprite.play("idle")

func _on_BattleFieldTile_body_entered(body):
	rigid_body_collision_shape.set_deferred("disabled", false)
	rigid_body.power = body.power
	animated_sprite.play("attacked")

func _on_BattleFieldTile_body_exited(body):
	rigid_body_collision_shape.set_deferred("disabled", true)
	rigid_body.power = 0
	animated_sprite.play("idle")
